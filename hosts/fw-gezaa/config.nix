{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/boot.nix
    ../../modules/graphics.nix
    ../../modules/power-management.nix
    ../../modules/home-manager/standard.nix
  ];

  modules.powerManagement.tlp.enable = true;
  services.fprintd.enable = true;
  networking.hostName = "fw-gezaa";

  home-manager.users.gezaa = {pkgs, ...}: {
    programs.niri.settings = {
      outputs."eDP-1".scale = 1.0;
    };
  };
}
