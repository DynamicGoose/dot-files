{ config, lib, ... }: {
  options.modules.desktopManagers.plasma.enable = lib.mkEnableOption "Enable Plasma 6 Desktop";

  config.services = lib.mkIf (config.modules.desktopManagers.plasma.enable) {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  }
}
