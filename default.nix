{ config, pkgs, ... }: {
  imports = [
    ./modules
  ];

  system.stateVersion = "25.05";
}
