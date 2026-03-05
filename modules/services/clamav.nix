{
  services.clamav = {
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
