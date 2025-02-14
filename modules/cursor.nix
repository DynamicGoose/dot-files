{ config, pkgs, inputs, ... }: {
  home-manager.users.gezaa = { config, ... }: {
    home.pointerCursor = {
      name = "graphite-dark";
      package = pkgs.graphite-cursors;
      size = 24;
      gtk.enable = true;
    };
  };
}
