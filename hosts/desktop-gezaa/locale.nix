{ lib, ... }:
{
  console.keyMap = lib.mkForce "us";
  services.xserver.xkb = lib.mkForce {
    layout = "eu";
    variant = "";
  };
}
