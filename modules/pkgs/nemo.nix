{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.modules.pkgs.nemo.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf (config.modules.pkgs.nemo.enable) {
    environment.systemPackages = [
      pkgs.nemo-with-extensions
      pkgs.xarchiver
    ];

    services.gvfs.enable = true;
  };
}
