{ config, pkgs, lib, ... }: {
  options.modules.displayManagers.sddm.enable = lib.mkEnableOption = "enable SDDM";

  config.services.displayManagers.sddm.enable = config.modules.displayManagers.sddm.enable;
}
