{
  username,
  ...
}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.${username} =
    { config, ... }:
    {
      home.stateVersion = "25.05";
    };
}
