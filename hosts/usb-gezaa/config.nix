{
  inputs,
  config,
  pkgs,
  ...
}: {
  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
      splashImage = null;
      # UUID needs to be adjusted on new install
      extraEntries = ''
        menuentry "Netboot.xyz" {
          insmod part_gpt
          insmod ext2
          insmod chain
          search --no-floppy --fs-uuid --set root aa18d19c-9806-417e-be19-71065c50d455
          chainloader ${pkgs.netbootxyz-efi}
        }
      '';
    };
  };
  
  # Power management
  services.cpupower-gui.enable = true;

  # Hostname
  networking.hostName = "usb-gezaa";

  # Home-Manager
  home-manager.users.gezaa = {pkgs, ...}: {
    # Hyprland
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          ", preferred, auto, 1"
        ];
      };
    };

    # Waybar
    programs.waybar = {
      settings = [
        {
          "spacing" = 4;
          "layer" = "top";
          "position" = "top";
          "margin-top" = 6;
          "margin-bottom" = 0;
          "margin-left" = 6;
          "margin-right" = 6;
          "height" = 34;
          "modules-left" = ["clock" "hyprland/workspaces"];
          "modules-center" = ["hyprland/window"];
          "modules-right" = ["tray" "pulseaudio" "backlight" "battery" "custom/menu"];

          "hyprland/workspaces" = {
            "on-click" = "activate";
            "sort-by-number" = true;
            "all-outputs" = true;
            "active-only" = false;
          };

          "backlight" = {
            "format" = "{icon} {percent}%";
            "format-icons" = ["󰃞" "󰃟" "󰃠"];
          };

          "battery" = {
            "format" = "{icon} {capacity}%";
            "format-icons" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };

          "clock" = {
            "format" = "󱑇 {:%H:%M}";
          };

          "pulseaudio" = {
            "format" = "{icon} {volume}%";
            "format-bluetooth" = "{icon}󰂯 {volume}%";
            "format-muted" = "";
            "format-icons" = {
              "headphones" = "󰋋 ";
              "phone" = " ";
              "default" = [" " " "];
            };
            "on-click" = "pwvucontrol";
          };

          "tray" = {
            "spacing" = 4;
            "reverse-direction" = true;
          };

          "custom/menu" = {
            "format" = "";
            "on-click" = "swaync-client -t";
            "tooltip-format" = "Menu";
          };
        }
      ];
    };

    # Swaync
    xdg.configFile = {
      "swaync-config" = {
        enable = true;
        target = "swaync/config.json";
        text = ''
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
            "notification-window-width": 500,
            "keyboard-shortcuts": true,
            "image-visibility": "when-available",
            "transition-time": 200,
            "hide-on-clear": false,
            "hide-on-action": true,
            "script-fail-notify": true,
            "widgets": [
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
                    "label": "󰐥",
                    "command": "systemctl poweroff"
                  },
                  {
                    "label": "󰜉",
                    "command": "systemctl reboot"
                  },
                  {
                    "label": "",
                    "command": "systemctl hibernate"
                  },
                  {
                    "label": "󰍃",
                    "command": "hyprctl dispatch exit"
                  },
                  {
                    "label": "󰏥",
                    "command": "systemctl suspend"
                  },
                  {
                    "label": "󰍺",
                    "command": "wdisplays"
                  },
                  {
                    "label": "󱐋",
                    "command": "cpupower-gui"
                  },
                  {
                    "label": "󰖩",
                    "command": "nm-connection-editor"
                  },
                  {
                    "label": "󰂯",
                    "command": "blueman-manager"
                  },
                  {
                    "label": "",
                    "command": "kooha"
                  }
                ]
              }
            }
          }
        '';
      };
    };
  };
}
