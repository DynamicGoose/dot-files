{ hostName, ... }:
{
  imports = [
    ./modules
  ];

  networking.hostName = hostName;

  system.stateVersion = "26.05";
}
