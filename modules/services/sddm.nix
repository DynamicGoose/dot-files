{
  config,
  lib,
  ...
}:
{
  options.modules.displayManager.sddm.enable = lib.mkEnableOption "enable SDDM";

  config.services.displayManager.sddm.enable = config.modules.displayManager.sddm.enable;
}
