{ config, lib, ... }:
{
  options.modules.desktop.plasma.enable = lib.mkEnableOption "Enable KDE Plasma 6 Desktop";

  config = lib.mkIf (config.modules.desktop.plasma.enable) {
    services = {
      xserver.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}
