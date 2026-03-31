{ hostName, ... }:
{
  imports = [
    ./modules/mobile
  ];

  networking.hostName = hostName;

  system.stateVersion = "26.05";
}
