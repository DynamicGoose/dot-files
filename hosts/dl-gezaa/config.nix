{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    splashImage = null;
  };

  # Graphics
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-sdk
    intel-media-driver
    intel-vaapi-driver
    libvdpau-va-gl
  ];
  
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    WLR_DRM_NO_ATOMIC = 1;
  };

  # Disable lightdm
  services.xserver.displayManager.lightdm.enable = lib.mkDefault false;
  # Disable Hyprland
  programs.hyprland.enable = lib.mkDefault false;
  # enable Cage
  services.cage.enable = true;

  # Hostname
  networking.hostName = "dl-gezaa";

  # Home-Manager
  home-manager.users.gezaa = {pkgs, ...}: {
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
