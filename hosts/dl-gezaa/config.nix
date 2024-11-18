{
  inputs,
  config,
  pkgs,
  ...
}: {
  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    splashImage = null;
  };

  # Graphics
  # hardware.graphics.extraPackages = with pkgs; [
  #   intel-media-sdk
  #   intel-media-driver
  #   intel-vaapi-driver
  #   libvdpau-va-gl
  # ];
  
  environment.sessionVariables = {
    # LIBVA_DRIVER_NAME = "iHD";
    WLR_DRM_NO_ATOMIC = 1;
  };

  # Let Hyprland use legacy renderer
  programs.hyprland.package = pkgs.hyprland.override {legacyRenderer = true;};
  
  # Power management
  services.cpupower-gui.enable = true;
  services.tlp.enable = true;

  # Hostname
  networking.hostName = "dl-gezaa";

  # Home-Manager
  home-manager.users.gezaa = {pkgs, ...}: {
    # Hyprland
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          ", preferred, auto, 1"
        ];

        exec-once = [
          "hypridle"
        ];

        decoration = {
          blur.enabled = lib.mkDefault false;
        };
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
