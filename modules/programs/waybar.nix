{ config, pkgs, lib, inputs, ... }: {
  options.modules.programs.waybar.desktop = lib.mkEnableOption "desktop config";

  config = let
    waybarSettings = if (config.modules.programs.waybar.desktop) then [
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
    ] else [
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
        "modules-right" = ["tray" "pulseaudio" "backlight" "battery" "custom/menu"];

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
          "tooltip" = false;
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
  in {
    home-manager.users.gezaa = { config, lib, ... }: {
      programs.waybar = {
        enable = true;

        settings = waybarSettings;
      
        style = ''
          * {
            font-size: 16px;
            font-family: "Ubuntu Nerdfont";
            font-weight: Bold;
            padding: 0 4px 0 4px;
          }
          window#waybar {
            background: rgba(15, 15, 15, 0.999);
            color: #E0E0E0;
            border: Solid;
            border-radius: 10px;
            border-width: 2px;
            border-color: #E0E0E0;
          }
          #workspaces button {
            background: #0F0F0F;
            color: #E0E0E0;
            margin: 4px 2px 4px 2px;
            padding: 0;
          }
          #workspaces button.active {
            background: #0F0F0F;
            color: #E0E0E0;
            margin: 4px 2px 4px 2px;
          }
          #tray {
            padding: 0;
          }
        '';      
      };
    };
  };
}
