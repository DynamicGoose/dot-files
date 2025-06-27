{
  pkgs,
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
          let carapace_completer = {|spans: list<string>|
            ${pkgs.carapace}/bin/carapace $spans.0 nushell ...$spans
            | from json
            | if ($in | default [] | where vaue == $"($spans | last)ERR" | is-empty) { $in } else { null }
          }

          let fish_completer = {|spans|
            ${pkgs.fish}/bin/fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
            | from tsv --flexible --noheaders --no-infer
            | rename value description
            | update value {
              if ($in | path exists) {$'"($in | path expand --no-symlink | str replace --all "\"" "\\\"" )"'} else {$in}
            }
          }

          let external_completer = {|spans|
            let expanded_alias = scope aliases
            | where name == $spans.0
            | get -i 0.expansion

            let spans = if $expanded_alias != null {
              $spans
              | skip 1
              | prepend ($expanded_alias | split row ' ' | take 1)
            } else {
              $spans
            }

            match $spans.0 {
              # carapace completions are incorrect for nu
              nu => $fish_completer
              # fish completes commits and branch names in a nicer way
              git => $fish_completer
              _ => $carapace_completer
            } | do $in $spans
          }

          $env.config = {
            show_banner: false,
            completions: {
              case_sensitive: false # case-sensitive completions
              quick: true    # set to false to prevent auto-selecting completions
              partial: true    # set to false to prevent partial filling of the prompt
              algorithm: "fuzzy"    # prefix or fuzzy
              external: {
                # set to false to prevent nushell looking into $env.PATH to find more suggestions
                enable: true 
                # set to lower can improve completion performance at the cost of omitting some options
                max_results: 100 
                completer: $external_completer # check 'carapace_completer' 
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
        };
      };
    };
}
