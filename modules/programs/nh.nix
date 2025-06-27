{
  config,
  lib,
  username,
  ...
}:
{
  options.modules.programs.nh.configPath = lib.mkOption {
    type = lib.types.str;
    default = "/home/${username}/git/dot-files";
  };

  config.programs.nh = {
    enable = true;
    flake = config.modules.programs.nh.configPath;
  };
}
