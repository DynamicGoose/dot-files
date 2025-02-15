{ config, pkgs, inputs, ... }: {
  home-manager.users.${config.modules.users.username} = { config, ... }: {
    home.pointerCursor = {
      name = "graphite-dark";
      package = pkgs.graphite-cursors;
      size = 24;
      gtk.enable = true;
    };
  };
}
