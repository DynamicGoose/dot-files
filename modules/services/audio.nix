{ config, lib, ... }: {
  options.modules.services.audio.disable = lib.mkEnableOption "disable audio config";

  config = lib.mkIf (!config.modules.services.audio.disable) {
    services = {
      pipewire = {
        enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      pulseaudio.enable = true;
    };
  };
}
