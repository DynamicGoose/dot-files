{
  pkgs,
  username,
  ...
}:
{
  modules = {
    powerManagement.ppd.enable = true;
    services.illuminanced.enable = true;
  };

  environment.systemPackages = [ pkgs.framework-tool ];

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
      # config file for illuminanced service
      xdg.configFile."illuminanced.toml".text = ''
        [daemonize]
        # log_to = "syslog" or /file/path
        log_to = "syslog"
        pid_file = "/run/illuminanced.pid"
        # log_level = "OFF", "ERROR", "WARN", "INFO", "DEBUG", "TRACE"
        log_level = "WARN"

        [general]
        check_period_in_seconds = 1
        light_steps = 10
        min_backlight = 70
        step_barrier = 0.1
        max_backlight_file = "/sys/class/backlight/amdgpu_bl1/max_brightness"
        backlight_file = "/sys/class/backlight/amdgpu_bl1/brightness"
        illuminance_file = "/sys/bus/iio/devices/iio:device0/in_illuminance_raw"
        event_device_mask = "/dev/input/event*"
        # use `sudo evtest` to see devices and provided keycodes in hex
        event_device_name = "AT Translated Set 2 keyboard"
        enable_max_brightness_mode = true
        filename_for_sensor_activation = ""
        # use `sudo showkey` to find the key code
        # use 0xXXX for hex value
        switch_key_code = 226 #  KEY_ALS_TOGGLE

        [kalman]
        q = 1
        r = 20
        covariance = 10

        [light]
        points_count = 6

        illuminance_0 = 0
        light_0 = 0

        illuminance_1 = 20
        light_1 = 1

        illuminance_2 = 300
        light_2 = 3

        illuminance_3 = 700
        light_3 = 4

        illuminance_4 = 1100
        light_4 = 5

        illuminance_5 = 7100
        light_5 = 10

      '';

      programs.niri.settings = {
        outputs."eDP-1".scale = 1.0;
        spawn-at-startup = [
          {
            command = [
              "sh"
              "-c"
              "systemctl --user start wluma.service"
            ];
          }
        ];
      };
    };
}
