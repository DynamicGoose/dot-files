{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/bootloader/grub_uefi.nix
    ../../modules/graphics/intel.nix
    ../../modules/power-management/with_tlp.nix
    ../../modules/home-manager/standard.nix
  ];

  networking.hostName = "tp-gezaa";
}
