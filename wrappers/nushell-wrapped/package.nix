{
  inputs,
  pkgs,
  lib,
}:
let
  starship-wrapped = pkgs.callPackage ../starship-wrapped/package.nix {
    inputs = inputs;
  };
in
inputs.wrapper-modules.wrappers.nushell.wrap {
  inherit pkgs;
  extraPackages = [
    starship-wrapped
    pkgs.zoxide
    pkgs.carapace
    pkgs.fish
  ];
  "env.nu".content = "";
  "config.nu".content = ''
    let base00 = "#0f0f0f" # Default Background
    let base01 = "#181818" # Lighter Background (Used for status bars, line number and folding marks)
    let base02 = "#222222" # Selection Background
    let base03 = "#2c2c2c" # Comments, Invisibles, Line Highlighting
    let base04 = "#333333" # Dark Foreground (Used for status bars)
    let base05 = "#616161" # Default Foreground, Caret, Delimiters, Operators
    let base06 = "#9e9e9e" # Light Foreground (Not often used)
    let base07 = "#e0e0e0" # Light Background (Not often used)
    let base08 = "#f44336" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    let base09 = "#ffd600" # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    let base0a = "#fb8c00" # Classes, Markup Bold, Search Text Background
    let base0b = "#66bb6a" # Strings, Inherited Class, Markup Code, Diff Inserted
    let base0c = "#4db6ac" # Support, Regular Expressions, Escape Characters, Markup Quotes
    let base0d = "#42a5f5" # Functions, Methods, Attribute IDs, Headings
    let base0e = "#ba68c8" # Keywords, Storage, Selector, Markup Italic, Diff Changed
    let base0f = "#f06292" # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

    let base16_theme = {
        separator: $base03
        leading_trailing_space_bg: $base04
        header: $base0b
        datetime: $base0e
        filesize: $base0d
        row_index: $base0c
        bool: $base08
        int: $base0b
        duration: $base08
        range: $base08
        float: $base08
        string: $base04
        nothing: $base08
        binary: $base08
        cell-path: $base08
        hints: dark_gray

        shape_garbage: { fg: $base07 bg: $base08 attr: b } # base16 white on red
        # but i like the regular white on red for parse errors
        # shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b }
        shape_bool: $base0d
        shape_int: { fg: $base0e attr: b }
        shape_float: { fg: $base0e attr: b }
        shape_range: { fg: $base0a attr: b }
        shape_internalcall: { fg: $base0c attr: b }
        shape_external: $base0c
        shape_externalarg: { fg: $base0b attr: b }
        shape_literal: $base0d
        shape_operator: $base0a
        shape_signature: { fg: $base0b attr: b }
        shape_string: $base0b
        shape_filepath: $base0d
        shape_globpattern: { fg: $base0d attr: b }
        shape_variable: $base0e
        shape_flag: { fg: $base0d attr: b }
        shape_custom: { attr: b }
    }

    $env.config.color_config = $base16_theme # <-- this is the theme
    $env.config.ls.use_ls_colors = true
    $env.config.use_ansi_coloring = true
    $env.config.table.mode = 'single'

    # carapce completions
    let carapace_completer = {|spans: list<string>|
      ^${lib.getExe pkgs.carapace} $spans.0 nushell ...$spans
      | from json
      | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
    }
    # some completions are only available through a bridge
    $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
    $env.CARAPACE_MATCH = 1

    # fish completions
    let fish_completer = {|spans|
      ^${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
      | $"value(char tab)description(char newline)" + $in
      | from tsv --flexible --no-infer
    }

    # zoxide completions
    let zoxide_completer = {|spans|
        $spans | skip 1 | ${lib.getExe pkgs.zoxide} query -l ...$in | lines | where {|x| $x != $env.PWD}
    }

    # multiple completions
    # the default will be carapace, but you can also switch to fish
    let multiple_completers = {|spans|
      ## alias fixer start
      let expanded_alias = scope aliases
      | where name == $spans.0
      | get -o 0.expansion

      let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
      } else {
        $spans
      }
      ## alias fixer end

      match $spans.0 {
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
      } | do $in $spans
    }

    $env.config = {
      show_banner: false,
      completions: {
        case_sensitive: false # case-sensitive completions
        quick: true           # set to false to prevent auto-selecting completions
        partial: true         # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
          # set to false to prevent nushell looking into $env.PATH to find more suggestions
          enable: true 
          # set to lower can improve completion performance at the cost of omitting some options
          max_results: 100 
          completer: $multiple_completers
        }
      }
      keybindings: [
        {
          name: interactive_cd
          modifier: control
          keycode: char_f
          mode: emacs
          event: {
            send: executehostcommand
            cmd: zi
          }
        }
      ]
    } 
    $env.PATH = ($env.PATH | 
    split row (char esep) |
    prepend /home/myuser/.apps |
    append /usr/bin/env
    )

    source ${
      pkgs.runCommand "zoxide-nushell.nu" { } ''
        ${lib.getExe pkgs.zoxide} init nushell >> "$out"
      ''
    }

    use ${
      pkgs.runCommand "starship-nushell.nu" { } ''
        ${lib.getExe starship-wrapped} init nu >> "$out"
      ''
    }

    source ${
      pkgs.runCommand "carapace-nushell.nu" { } ''
        ${lib.getExe pkgs.carapace} _carapace nushell | sed 's|"/homeless-shelter|$"($env.HOME)|g' >> "$out"
      ''
    }

    alias ".." = cd ..
    alias "cd" = z
    alias "ll" = ls -l
  '';
}
