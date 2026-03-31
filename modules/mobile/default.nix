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

  # allow mobile-specific passwords
  users.users.${username}.hashedPasswordFile =
    lib.mkForce "/home/${username}/secrets/${username}-mobile";
  users.users.root.hashedPasswordFile = lib.mkForce "/home/${username}/secrets/root-mobile";

  # modem-manager
  networking.modemmanager.enable = true;
}
