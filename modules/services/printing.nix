{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = [
        pkgs.gutenprint
        pkgs.epson-escpr2
      ];
    };

    # autodiscovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
