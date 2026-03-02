{ lib, pkgs, ... }:
{
  modules = {
    boot.deviceType = "removable";
    graphics.enable = false;
    services.hypridle.desktop = true;
  };

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
}
