{ config, pkgs, ... }: {
  imports = [
    ./modules/boot.nix
    ./modules/cursor.nix
    ./modules/firmware.nix
    ./modules/fonts.nix
    ./modules/graphics.nix
    ./modules/gtk.nix
    ./modules/home-manager.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/niri.nix
    ./modules/nix.nix
    ./modules/nixpkgs.nix
    ./modules/power-management.nix
    ./modules/qt.nix
    ./modules/security.nix
    ./modules/systemd.nix
    ./modules/users.nix
    ./modules/virtualisation.nix
    ./modules/zsh.nix
    ./modules/packages/nemo.nix
    ./modules/packages/packages.nix
    ./modules/packages/swaync.nix
    ./modules/packages/wofi-power-menu.nix
    ./modules/programs/alvr.nix
    ./modules/programs/evince.nix
    ./modules/programs/helix.nix
    ./modules/programs/hyprlock.nix
    ./modules/programs/steam.nix
    ./modules/programs/virt-manager.nix
    ./modules/programs/waybar.nix
    ./modules/programs/wofi.nix
    ./modules/services/audio.nix
    ./modules/services/dbus.nix
    ./modules/services/hypridle.nix
    ./modules/services/lightdm.nix
    ./modules/services/printing.nix
    ./modules/services/ssh.nix
    ./modules/services/syncthing.nix
    ./modules/services/xserver.nix
  ];

  system.stateVersion = "25.05";
}
