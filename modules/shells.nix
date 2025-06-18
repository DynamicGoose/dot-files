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

  progrmams.bash.interactiveShellInit = "eval \"$(starship init bash)\"";

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

      programs.starshiship = {
        enable = true;
        settings = {
          add_newline = false;
          format = "┌ $all";
          character = {
            success_symbol = "└ [❯](bold green)";
            error_symbol = "└ [❯](bold red)";
          };
        };
      };
    };
}
