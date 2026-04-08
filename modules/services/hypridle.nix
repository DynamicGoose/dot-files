{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  options.modules.services.hypridle.desktop = lib.mkEnableOption "hypridle desktop config";

  config =
    let
      hypridle-config = pkgs.writeText "hypridle.conf" (
        if (!config.modules.services.hypridle.desktop) then
          ''
            general {
              lock_cmd = goose-shell ipc call session lock
              before_sleep_cmd = niri msg action power-off-monitors
              after_sleep_cmd = loginctl lock-session && niri msg action power-on-monitors
            }

            listener {
              timeout = 150
              on-timeout = brightnessctl -s set 10
              on-resume = brightnessctl -r
            }

            listener {
              timeout = 150
              on-timeout = brightnessctl -sd rgb:kbd_backlight set 0
              on-resume = brightnessctl -rd rgb:kbd_backlight
            }

            listener {
              timeout = 300
              on-timeout = loginctl lock-session
            }

            listener {
              timeout = 380
              on-timeout = niri msg action power-off-monitors
              on-resume = niri msg action power-on-monitors
            }

            listener {
              timeout = 1800
              on-timeout = systemctl suspend
            }
          ''
        else
          ''
            general {
              lock_cmd = goose-shell ipc call session lock
              before_sleep_cmd = niri msg action power-off-monitors
              after_sleep_cmd = loginctl lock-session && niri msg action power-on-monitors
            }
          ''
      );
    in
    {
      environment.systemPackages = lib.mkIf (!config.modules.services.hypridle.desktop) [
        pkgs.brightnessctl
      ];

      services.hypridle.enable = true;

      # Copy hypridle config
      systemd.services.hypridleConfig =
        let
          copy-config = pkgs.writeShellScript "copy-kvantum-config.sh" ''
            ${pkgs.coreutils}/bin/mkdir -p /home/${username}/.config/hypr
            ${pkgs.coreutils}/bin/ln -sf ${hypridle-config} /home/${username}/.config/hypr/hypridle.conf
          '';
        in
        {
          description = "Copy Hypridle user config";
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = copy-config;
          };
        };
    };
}
