{ config, lib, ... }: {
  options.modules = {
    powerManagement.tlp.enable = lib.mkEnableOption "enable tlp";
  };

  config = {
    services.cpupower-gui.enable = true;
    services.tlp = lib.mkIf (config.modules.powerManagement.tlp.enable == true) {
      enable = true;
      settings = {
        # disable adaptive brightness on amd
        AMDGPU_ABM_LEVEL_ON_BAT = 0;
      };
    };
  };
}
