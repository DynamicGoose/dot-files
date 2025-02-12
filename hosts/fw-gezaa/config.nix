{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/boot.nix
    ../../modules/graphics/amd.nix
    ../../modules/power-management/with_tlp.nix
    ../../modules/home-manager/standard.nix
  ];
  
  services.fprintd.enable = true;
  networking.hostName = "fw-gezaa";

  home-manager.users.gezaa = {pkgs, ...}: {
    programs.niri.settings = {
      outputs."eDP-1".scale = 1.0;
    };
  };
}
