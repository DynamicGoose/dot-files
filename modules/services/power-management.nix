{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.modules.powerManagement = {
    tlp.enable = lib.mkEnableOption "enable tlp";
    ppd.enable = lib.mkEnableOption "enable power-profiles-daemon";
    hdparm.enable = lib.mkEnableOption "enable HDD power-saving";
  };

  config = {
    services.tlp = lib.mkIf (config.modules.powerManagement.tlp.enable) {
      enable = true;
      settings = {
        # disable adaptive brightness on amd
        AMDGPU_ABM_LEVEL_ON_BAT = 0;
      };
    };

    services.udev.extraRules = lib.mkIf (config.modules.powerManagement.hdparm.enable) ''
      ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", RUN+="${pkgs.hdparm}/bin/hdparm -B 90 -S 41 /dev/%k"
    '';

    services.power-profiles-daemon.enable = config.modules.powerManagement.ppd.enable;

    services.upower.enable =
      config.modules.powerManagement.tlp.enable || config.modules.powerManagement.ppd.enable;
  };
}
