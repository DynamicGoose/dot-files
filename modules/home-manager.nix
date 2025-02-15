{ config, inputs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.${config.modules.users.username} = { config, ... }: {
    home.stateVersion = "25.05";
  };
}
