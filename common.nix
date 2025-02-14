{ config, pkgs, ... }: {
  imports = [
    ./modules/niri.nix
    ./modules/qt.nix
    ./modules/users.nix
    ./modules/graphics.nix
    ./modules/security.nix
    ./modules/power-management.nix
    ./modules/locale.nix
    ./modules/systemd.nix
    ./modules/gtk.nix
    ./modules/nix.nix
    ./modules/networking.nix
    ./modules/boot.nix
    ./modules/virtualisation.nix
    ./modules/cursor.nix
    ./modules/nixpkgs.nix
    ./modules/zsh.nix
    ./modules/fonts.nix
    ./modules/home-manager.nix
    ./modules/services/audio.nix
    ./modules/services/xserver.nix
    ./modules/services/hypridle.nix
    ./modules/services/syncthing.nix
    ./modules/services/ssh.nix
    ./modules/services/printing.nix
    ./modules/services/dbus.nix
    ./modules/services/lightdm.nix
    ./modules/packages/packages.nix
    ./modules/packages/nemo.nix
    ./modules/packages/wofi-power-menu.nix
    ./modules/packages/swaync.nix
    ./modules/programs/alvr.nix
    ./modules/programs/virt-manager.nix
    ./modules/programs/steam.nix
    ./modules/programs/wofi.nix
    ./modules/programs/waybar.nix
    ./modules/programs/hyprlock.nix
    ./modules/programs/evince.nix
    ./modules/programs/helix.nix
  ];

  system.stateVersion = "25.05";
}
