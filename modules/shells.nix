{
  pkgs,
  lib,
  username,
  ...
}:
{
  environment.shells = with pkgs; [
    nushell
    bash
  ];

  programs.bash.interactiveShellInit = "eval \"$(starship init bash)\"";

  home-manager.users.${username} =
    { config, pkgs, ... }:
    {
      programs.nushell = {
        enable = true;
        configFile.text = ''
          # carapce completions
          let carapace_completer = {|spans: list<string>|
            carapace $spans.0 nushell ...$spans
            | from json
            | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
          }
          # some completions are only available through a bridge
          $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

          # fish completions
          let fish_completer = {|spans|
            ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
            | $"value(char tab)description(char newline)" + $in
            | from tsv --flexible --no-infer
          }

          # zoxide completions
          let zoxide_completer = {|spans|
              $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
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
        '';

        shellAliases = {
          ll = "ls -l";
          ".." = "cd ..";
        };
      };

      programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
      };

      programs.starship = {
        enable = true;
        settings = {
          add_newline = false;
          format = "[┌](white) $all";
          character = {
            success_symbol = "[└](white) [❯](bold green)";
            error_symbol = "[└](white) [❯](bold red)";
          };
          nix_shell = {
            format = "via [$symbol(\\($name\\)) ]($style)";
            symbol = "󱄅 ";
          };
          battery.disabled = true;
        };
      };
    };
}
