{
  inputs,
  config,
  pkgs,
  ...
}: {
  home-manager.users.gezaa = {pkgs, ...}: {
    # Hyprland
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "DP-1, 2560x1440@240, 1920x0, 1"
          "HDMI-A-1, 1920x1080@60, 0x0, 1"
        ];
      };
    };

    # Niri
    programs.niri.settings.outputs = {
      "DP-1" = {
        mode = {
          width = 2560;
          height = 1440;
          refresh = 240.0;
        };
        position = {
          x = 1920;
          y = 0;
        };
      };
      "HDMI-A-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        position = {
          x = 0;
          y = 0;
        };
      };
    };
    
    # Hypridle
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || niri msg action do-screen-transition && hyprlock --no-fade-in";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [];
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
          "modules-left" = ["clock" "niri/workspaces"];
          "modules-center" = ["niri/window"];
          "modules-right" = ["tray" "pulseaudio" "custom/menu"];

          "niri/workspaces" = {
            "on-click" = "activate";
            "all-outputs" = false;
            "active-only" = false;
            "format" = "{icon}";
            "format-icons" = {
              "default" = "";
              "active" = "";
            };
          };

          "niri/window" = {
            "icon" = true;
          };
          
          "clock" = {
            "format" = "󱑇 {:%H:%M}";
            "tooltip" = false;
          };

          "pulseaudio" = {
            "format" = "{icon} {volume}%";
            "format-bluetooth" = "{icon}󰂯 {volume}%";
            "format-muted" = "";
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
  };
}
