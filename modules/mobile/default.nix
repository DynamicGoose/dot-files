{ lib, username, ... }:
{
  imports = [
    # imports from normal desktop
    # core
    ../core/home-manager.nix
    ../core/locale.nix
    ../core/networking.nix
    ../core/nix.nix
    ../core/nixpkgs.nix
    ../core/security.nix
    ../core/shells.nix
    ../core/systemd.nix
    ../core/users.nix
    # ../core/virtualisation.nix
    # desktop
    ../desktop/cursor.nix
    ../desktop/fonts.nix
    ../desktop/gtk.nix
    ../desktop/qt.nix
    # hardware
    # ../hardware/firmware.nix
    # pkgs
    ../pkgs
    # programs
    ../programs
    # services
    ../services

    # mobile modules
    ./desktop
    ./pkgs
  ];

  modules.displayManager.lightdm.enable = false; # disable lightdm (bc mobile interface)
  modules.pkgs.nemo.enable = false; # disable nemo (bc mobile interface)
  modules.programs.gpu-screen-recorder.enable = false; # disable bc incompatible
  modules.programs.steam.enable = false; # disable steam

  hardware.graphics.enable32Bit = lib.mkForce false; # disable 32 bit graphics bc mobile

  # allow mobile-specific passwords
  users.users.${username}.hashedPasswordFile =
    lib.mkForce "/home/${username}/secrets/${username}-mobile";
  users.users.root.hashedPasswordFile = lib.mkForce "/home/${username}/secrets/root-mobile";

  # modem-manager
  networking.modemmanager.enable = true;

  programs.steam.enable = lib.mkForce false;
}
