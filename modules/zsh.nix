{ config, pkgs, inputs, username, ... }: {
  environment.shells = with pkgs; [zsh bash];

  programs.zsh = {
    enable = true;
    interactiveShellInit = "source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh";
  };

  home-manager.users.${username} = { config, pkgs, ... }: {
    programs.zsh = {
      enable = true;
      history = {
        size = 1000;
        save = 1000;
      };

      autocd = true;
      defaultKeymap = "emacs";

      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
      };

      initExtra = ''
        autoload -Uz vcs_info
        setopt prompt_subst
        zstyle ':vcs_info:*' actionformats ' %F{3}-> %F{4}%f%F{4}%s%F{255}:%F{5}%b|%F{4}%a%F{3}%u%f'
        zstyle ':vcs_info:*' formats ' %F{3}-> %F{4}%f%F{4}%s%F{255}:%F{6}%b%f'
        zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
        precmd () { vcs_info }

        if [[ -n $IN_NIX_SHELL ]]; then
          PS1='%F{2}[nix-shell]%F{255} %~/''${vcs_info_msg_0_}%F{1} ❯%F{255} '
        else
          PS1='%~/''${vcs_info_msg_0_}%F{1} ❯%F{255} '
        fi
      '';
    };
  };
}
