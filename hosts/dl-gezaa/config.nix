{
  lib,
  username,
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

  # Home-Manager
  home-manager.users.${username} =
    { pkgs, ... }:
    {
      # Disable Hyprland hm module
      wayland.windowManager.hyprland.enable = lib.mkDefault false;

      # Disable other stuff
      programs.waybar.enable = lib.mkDefault false;
      programs.hyprlock.enable = lib.mkDefault false;
      programs.hypridle.enable = lib.mkDefault false;
      programs.wofi.enable = lib.mkDefault false;
      programs.wlogout.enable = lib.mkDefault false;
    };
}
