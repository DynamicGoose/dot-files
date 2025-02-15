{ config, pkgs, inputs, ... }: {
  environment.shells = with pkgs; [zsh bash];
  programs.zsh.enable = true;

  home-manager.users.${config.modules.users.username} = { config, ... }: {
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
        export PS1='%~/''${vcs_info_msg_0_}%F{1} ❯%F{255} '
      '';
    };
  };
}
