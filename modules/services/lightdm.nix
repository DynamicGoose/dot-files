{ config, pkgs, lib, ... }: {
  options.modules.displayManagers.lightdm.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
  
  config.services.xserver.displayManager.lightdm = lib.mkIf (config.modules.displayManagers.lightdm.enable) {
    enable = true;
    background = "${pkgs.graphite-gtk-theme.override {wallpapers = true;}}/share/backgrounds/wave-Dark.png";
    greeters.gtk = {
      enable = true;
      theme.package = pkgs.graphite-gtk-theme.override {tweaks = ["black"];};
      theme.name = "Graphite-Dark";
      iconTheme.package = pkgs.papirus-icon-theme;
      iconTheme.name = "Papirus-Dark";
      cursorTheme.package = pkgs.graphite-cursors;
      cursorTheme.name = "graphite-dark";
      cursorTheme.size = 24;
      indicators = [];
    };
  };
}
