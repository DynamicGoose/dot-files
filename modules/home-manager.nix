{ config, inputs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.gezaa = { config, ... }: {
    home.stateVersion = "25.05";
  };
}
