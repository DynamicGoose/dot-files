{ config, pkgs, hostname, ... }: {
  imports = [
    ./modules
  ];

  networking.hostName = hostname;
  
  system.stateVersion = "25.05";
}
