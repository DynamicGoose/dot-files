{
  inputs,
  config,
  pkgs,
  username,
  ...
}:
{
  modules.powerManagement.ppd.enable = true;

  services.fprintd.enable = true;

  # https://gitlab.freedesktop.org/drm/amd/-/issues/3647
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];

  # detect/manage display brightness
  hardware.sensor.iio.enable = true;

  services.udev.extraRules = ''
    # Ethernet expansion card support
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="8156", ATTR{power/autosuspend}="20"
  '';

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      programs.niri.settings = {
        outputs."eDP-1".scale = 1.0;
      };
    };
}
