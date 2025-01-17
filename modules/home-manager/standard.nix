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
          ", preferred, auto, 1"
        ];

        exec-once = [
          "hypridle"
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
    };
  };
}
