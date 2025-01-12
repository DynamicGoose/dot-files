{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/bootloader/grub_removable.nix
    ../../modules/power-management/gui_only.nix
    ../../modules/home-manager/standard.nix
  ];

  networking.hostName = "usb-gezaa";
}
