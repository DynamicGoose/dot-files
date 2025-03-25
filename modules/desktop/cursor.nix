{ config, pkgs, inputs, username, ... }: {
  home-manager.users.${username} = { config, ... }: {
    home.pointerCursor = {
      name = "graphite-dark";
      package = pkgs.graphite-cursors;
      size = 24;
      gtk.enable = true;
    };
  };
}
