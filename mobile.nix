# { pkgs, ... }:
{
  flavor = "lineageos";
  device = "enchilada";

  microg.enable = true;
  apps.fdroid.enable = true;

  # ccache.enable = true;

  signing.avb.enable = true;

  stateVersion = "3";
}
