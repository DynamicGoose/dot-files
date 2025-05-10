{
  username,
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

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      programs.niri.settings = {
        outputs."eDP-1".scale = 1.0;
      };
    };
}
