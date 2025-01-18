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
          "modules-right" = ["tray" "pulseaudio" "custom/menu"];

          "hyprland/workspaces" = {
            "on-click" = "activate";
            "all-outputs" = true;
            "active-only" = false;
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
