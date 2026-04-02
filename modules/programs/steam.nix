{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.programs.steam.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.programs.steam = lib.mkIf (config.modules.programs.steam.enable) {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
}
