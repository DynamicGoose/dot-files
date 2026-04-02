{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.programs.gpu-screen-recorder.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.programs.gpu-screen-recorder.enable = config.modules.programs.gpu-screen-recorder.enable;
  config.environment.systemPackages = lib.mkIf (config.modules.programs.gpu-screen-recorder.enable) [
    pkgs.gpu-screen-recorder-gtk
  ];
}
