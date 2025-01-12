{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/bootloader/grub_uefi.nix
    ../../modules/graphics/amd.nix
    ../../modules/power-management/with_tlp.nix
    ../../modules/home-manager/standard.nix
  ];

  networking.hostName = "hp-gezaa";
}
