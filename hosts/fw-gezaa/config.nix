{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  modules.powerManagement.tlp.enable = true;
  services.fprintd.enable = true;
  networking.hostName = "fw-gezaa";

  home-manager.users.gezaa = {pkgs, ...}: {
    programs.niri.settings = {
      outputs."eDP-1".scale = 1.0;
    };
  };
}
