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
          let carapace_completer = {|spans|
            carapace $spans.0 nushell ...$spans | from json
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
                completer: $carapace_completer # check 'carapace_completer' 
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
        };
      };
    };
}
