{ config, pkgs, inputs, ... }: {
  home-manager.users.${config.modules.users.username} = { config, ... }: {
    programs.helix = {
      enable = true;
      settings = {
        theme = "dark_high_contrast";

        editor = {
          mouse = false;
          line-number = "relative";
          color-modes = true;
        };

        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "block";
        };

        editor.indent-guides = {
          render = true;
          character = "▏";
          skip-levels = 1;
        };

        editor.soft-wrap = {
          enable = true;
          max-wrap = 25;
          max-indent-retain = 0;
          wrap-indicator = "▷ ";
        };
      };
    };
  };
}
