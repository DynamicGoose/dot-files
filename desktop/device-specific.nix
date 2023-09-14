{ inputs, config, pkgs, ... }:
{
  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };
  
  # Host name
  networking.hostName = "desktop-gezaa";

  home-manager.users.gezaa = { pkgs, ...}: {
    # Waybar
    programs.waybar = {
      enable = true;
      settings = [
        {
          "spacing" =  4;
          "layer" = "top";
          "position" = "top";
          "margin-top" = 6;
          "margin-bottom" = 0;
          "margin-left" = 6;
          "margin-right" = 6;
          "height" = 34;
          "modules-left" = [ "clock" "custom/display-settings" "wlr/workspaces" ];
          "modules-center" = [ "hyprland/window" ];
          "modules-right" = [ "tray" "pulseaudio" "custom/power"];

          "wlr/workspaces" = {
            "on-click" = "activate";
            "all-outputs" = true;
            "active-only" = false;
          };

          "clock" = {
            "format" = "󱑇 {:%H:%M}";
          };

          "pulseaudio" = {
            "format" = "{icon} {volume}%";
            "format-bluetooth" = "{icon}󰂯 {volume}%";
            "format-muted" = "";
            "format-icons" = {
              "headphones" = "󰋋";
              "phone" = "";
              "default" = ["" ""];
            };
            "on-click" = "pavucontrol";
          };

          "tray" = {
            "spacing" = 4;
            "reverse-direction" = true;
          };

          "custom/power" = {
            "format" = "⏻";
            "on-click" = "wlogout";
          };

          "custom/display-settings" = {
            "format" = "󰍺";
            "on-click" = "wdisplays";
          };
        }
      ];
      
      style = ''
        * {
          font-size: 16px;
          font-family: "Ubuntu Nerdfont";
          font-weight: Bold;
          padding: 0 4px 0 4px;
        }
        window#waybar {
          background: #0F0F0F;
          color: #E0E0E0;
          border: Solid;
          border-radius: 10px;
          border-width: 2px;
          border-color: #E0E0E0;
        }
        #workspaces button {
          background: #0F0F0F;
          margin: 4px 2px 4px 2px;
        }
        #workspaces button.active {
          background: #E0E0E0;
          color: #0F0F0F;
          margin: 4px 2px 4px 2px;
        }
        #tray {
          padding: 0;
        }
      '';
    };
  };
}