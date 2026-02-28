{
  username,
  inputs,
  ...
}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.${username} =
    { config, ... }:
    {
      home.stateVersion = "25.05";
      imports = [
        inputs.niri-nix.homeModules.default
      ];
    };
}
