{ lib, config, ... }:
{
  options.modules.security.clamav.enable =
    lib.mkEnableOption "Enable clamav antivirus (needs a lot of RAM)";

  config.services.clamav = lib.mkIf config.modules.security.clamav.enable {
    daemon.enable = true;
    updater = {
      enable = true;
      frequency = 4;
    };
    scanner = {
      enable = true;
      interval = "*-*-* 23:00:00";
      scanDirectories = [
        "/home"
        "/var/lib"
        "/tmp"
        "/etc"
        "/var/tmp"
      ];
    };
  };
}
