{
  config,
  ...
}: {
  services.cpupower-gui.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      # disable adaptive backlight brightness
      AMDGPU_ABM_LEVEL_ON_BAT = 0;
    };
  };
}
