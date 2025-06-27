{
  config,
  lib,
  ...
}:
{
  options.modules.configPath = lib.mkOption {
    type = lib.types.str;
    default = "~/git/dot-files";
  };

  config.programs.nh = {
    enable = true;
    flake = config.modules.configPath;
  };
}
