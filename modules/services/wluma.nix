{
  config,
  lib,
  username,
  ...
}:
{
  options.modules.services.wluma.enable =
    lib.mkEnableOption "Enable wluma automatic backlight control";

  config.home-manager.users.${username} = lib.mkIf (config.modules.services.wluma.enable) {
    services.wluma.enable = true;
  };
}
