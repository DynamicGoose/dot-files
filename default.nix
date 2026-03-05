{ hostName, ... }:
{
  imports = [
    ./modules
  ];

  networking.hostName = hostName;

  system.stateVersion = "25.05";
}
