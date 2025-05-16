{ lib, username, ... }:
{
  home-manager.users.${username} = {
    xdg.configFile."swaync/config.json".text = lib.mkOverride ''
      {
        "$schema": "/etc/xdg/swaync/configSchema.json",
        "positionX": "right",
        "positionY": "top",
        "control-center-margin-top": 6,
        "control-center-margin-bottom": 6,
        "control-center-margin-right": 6,
        "control-center-margin-left": 6,
        "notification-icon-size": 64,
        "notification-body-image-height": 100,
        "notification-body-image-width": 200,
        "timeout": 10,
        "timeout-low": 5,
        "timeout-critical": 0,
        "fit-to-screen": true,
        "notification-window-width": 588,
        "control-center-width": 588,
        "keyboard-shortcuts": true,
        "image-visibility": "when-available",
        "transition-time": 200,
        "hide-on-clear": false,
        "hide-on-action": true,
        "script-fail-notify": true,
        "widgets": [
          "menubar",
          "buttons-grid",
          "mpris",
          "volume",
          "backlight",
          "title",
          "dnd",
          "notifications"
        ],
        "widget-config": {
          "title": {
            "text": "Notifications",
            "clear-all-button": true,
            "button-text": "Clear All"
          },
          "dnd": {
            "text": "Do Not Disturb"
          },
          "label": {
            "max-lines": 1,
            "text": "Notification Center"
          },
          "mpris": {
            "image-size": 96,
            "image-radius": 8
          },
          "volume": {
            "label": "󰕾 "
          },
          "backlight": {
            "label": "󰃟 "
          },
          "buttons-grid": {
            "actions": [
              {
                "label": "",
                "command": "wofi"
              },
              {
                "label": "󰍺",
                "command": "wdisplays"
              },
              {
                "label": "",
                "command": "gpu-screen-recorder-gtk"
              }
            ]
          },
          "menubar": {
            "menu#power-buttons": {
              "label": "",
              "position": "left",
              "actions": [
                {
                  "label": " Shut down",
                  "command": "systemctl poweroff"
                },
                {
                  "label": "󰜉 Reboot",
                  "command": "systemctl reboot"
                },
                {
                  "label": "󰒲 Suspend",
                  "command": "systemctl suspend"
                },
                {
                  "label": "󰋊 Hibernate",
                  "command": "systemctl hibernate"
                },
                {
                  "label": "󰍃 Logout",
                  "command": "niri msg action quit -s"
                },
                {
                  "label": "󰌾 Lock Screen",
                  "command": "loginctl lock-session"
                }
              ]
            },
            "menu#power-profiles": {
              "label": "󱐋",
              "position": "left",
              "actions": [
                {
                  "label": "󰓅 Performance",
                  "command": "cpupower-gui -p"
                },
                {
                  "label": "󰾆 Power-Saver",
                  "command": "cpupower-gui -b"
                }
              ]
            }
          }
        }
      }
    '';
  };
}
