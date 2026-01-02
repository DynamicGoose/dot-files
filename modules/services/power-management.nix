{ config, lib, ... }:
{
  options.modules.powerManagement = {
    tlp.enable = lib.mkEnableOption "enable tlp";
    ppd.enable = lib.mkEnableOption "enable power-profiles-daemon";
  };

  config = {
    services.tlp = lib.mkIf (config.modules.powerManagement.tlp.enable) {
      enable = true;
      settings = {
        # disable adaptive brightness on amd
        AMDGPU_ABM_LEVEL_ON_BAT = 0;
      };
    };
    services.power-profiles-daemon.enable = config.modules.powerManagement.ppd.enable;
  };
}
