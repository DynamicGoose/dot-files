{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.modules.displayManager.greetd.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.programs.regreet = lib.mkIf (config.modules.displayManager.greetd.enable) {
    enable = true;
    theme.package = pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; };
    theme.name = "Graphite-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus-Dark";
    cursorTheme.package = pkgs.graphite-cursors;
    cursorTheme.name = "graphite-dark";
    settings.background.path = "${
      pkgs.graphite-gtk-theme.override { wallpapers = true; }
    }/share/backgrounds/wave-Dark.jpg";
  };
}
