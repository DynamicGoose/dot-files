{ config, lib, ... }:
{
  options.modules.services.audio.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf (config.modules.services.audio.enable) {
    services = {
      pipewire = {
        enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      pulseaudio.enable = false;
    };
  };
}
