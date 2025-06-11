{
  security = {
    sudo.enable = false;
    sudo-rs.enable = true;
    rtkit.enable = true;
    polkit.enable = true;

    pam.loginLimits = [
      {
        domain = "*";
        item = "rtprio";
        type = "-";
        value = 99;
      }
      {
        domain = "*";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "*";
        item = "nofile";
        type = "-";
        value = "99999";
      }
    ];
  };
  services.fail2ban.enable = true;
}
