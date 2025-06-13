{ config, lib, ... }:
{
  options.modules.services.clight.enable = lib.mkEnableOption "Enable clight daemon";

  config.services.clight.enable = config.modules.services.clight.enable;
}
