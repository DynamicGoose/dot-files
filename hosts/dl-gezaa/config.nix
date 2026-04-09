{
  lib,
  ...
}:
{
  # DEPRECATED

  imports = [
    ../../modules/bootloader/grub_legacy.nix
    ../../modules/graphics/intel.nix
  ];

  # Disable lightdm
  services.xserver.displayManager.lightdm.enable = lib.mkDefault false;
  # Disable Hyprland
  programs.hyprland.enable = lib.mkDefault false;
  # enable Cage
  services.cage.enable = true;
}
