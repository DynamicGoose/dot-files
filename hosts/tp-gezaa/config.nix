{
  pkgs,
  lib,
  inputs,
  system,
  ...
}:
{
  modules = {
    graphics.type = "intel";
    powerManagement.tlp.enable = true;
    displayManager.lightdm.enable = false;
    displayManager.sddm.enable = true;
    desktop.plasma.enable = true;
  };

  users.users.maiku = {
    isNormalUser = true;
    description = "Mai YAY";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
  };

  # niri settings
  programs.niri.package = lib.mkForce (
    pkgs.callPackage ../../wrappers/niri-wrapped/package.nix {
      settingsOverrides = {
        outputs."eDP-1".scale = 1.0;
      };
      inputs = inputs;
      system = system;
    }
  );
}
