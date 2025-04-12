{
  username,
  ...
}:
{
  modules = {
    graphics.type = "intel";
    powerManagement.tlp.enable = true;
  };

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      programs.niri.settings = {
        outputs."eDP-1".scale = 1.0;
      };
    };
}
