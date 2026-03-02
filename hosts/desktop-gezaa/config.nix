{
  username,
  ...
}:
{
  modules = {
    services.hypridle.desktop = true;
    powerManagement.hdparm.enable = true;
  };

  # CpuFreqGov performance mode
  powerManagement.cpuFreqGovernor = "performance";

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      wayland.windowManager.niri.settings = {
        output = [
          {
            _args = [ "DP-1" ];
            focus-at-startup = [ ];
            variable-refresh-rate = [ ];
          }
          {
            _args = [ "HDMI-A-1" ];
            mode = {
              _args = [ "1920x1080@74.906" ];
              _props.custom = true;
            };
          }
        ];

        spawn-sh-at-startup = [
          [ "sleep 1 && goose-shell ipc call networking setWifiEnabled false" ]
        ];
      };
    };
}
