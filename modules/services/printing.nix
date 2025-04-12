{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };

    # autodiscovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
