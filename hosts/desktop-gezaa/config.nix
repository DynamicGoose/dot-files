{
  pkgs,
  lib,
  inputs,
  system,
  ...
}:
{
  modules = {
    services.hypridle.desktop = true;
    powerManagement.hdparm.enable = true;
  };

  # CpuFreqGov performance mode
  powerManagement.cpuFreqGovernor = "performance";

  # niri settings
  programs.niri.package = lib.mkForce (
    pkgs.callPackage ../../wrappers/niri-wrapped/package.nix {
      settingsOverrides = {
        outputs = {
          "DP-1" = {
            focus-at-startup = _: { };
            variable-refresh-rate = _: { };
          };
          "HDMI-A-1" = {
            mode = _: {
              props = [
                { custom = true; }
                "1920x1080@74.906"
              ];
            };
          };
        };

        spawn-sh-at-startup = [
          "sleep 1 && ${lib.getExe pkgs.goose-shell} ipc call networking setWifiEnabled false"
        ];

        input.keyboard.xkb.layout = "eu";
      };
      inputs = inputs;
      system = system;
    }
  );
}
