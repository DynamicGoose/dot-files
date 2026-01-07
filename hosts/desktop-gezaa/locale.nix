{ lib, username, ... }:
{
  console.keyMap = lib.mkForce "us";
  services.xserver.xkb = lib.mkForce {
    layout = "eu";
    variant = "";
  };

  home-manager.users.${username} =
    { lib, config, ... }:
    {
      programs.niri.settings.input.keyboard.xkb.layout = lib.mkForce "eu";
    };
}
