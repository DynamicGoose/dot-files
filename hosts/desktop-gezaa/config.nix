{
  lib,
  pkgs,
  username,
  ...
}:
{
  modules = {
    programs.waybar.desktop = true;
    services.hypridle.desktop = true;
  };

  # CpuFreqGov performance mode
  powerManagement.cpuFreqGovernor = "performance";

  # zen4/5 optimized cachyos kernel
  boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      programs.niri.settings = {
        outputs = {
          "DP-1" = {
            focus-at-startup = true;
            variable-refresh-rate = true;
          };
          "HDMI-A-1".mode = {
            refresh = 74.906;
            width = 1920;
            height = 1080;
          };
        };
        spawn-at-startup = [
          {
            command = [
              "cpupower-gui"
              "-p"
            ];
          }
        ];
      };
    };
}
