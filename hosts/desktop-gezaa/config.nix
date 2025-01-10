{
  inputs,
  config,
  pkgs,
  ...
}: {
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
      splashImage = null;
    };
  };

  # AMD graphics drivers
  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
  };
    
  # LACT (amdgpu control-panel)
  environment.systemPackages = with pkgs; [ lact ];
  # lactd service
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
  # overclocking (kernel param)
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xffffffff"];
  
  # filesystem config and nix store on other device
  fileSystems = {
    "/nix" = {
      device = "/dev/disk/by-label/nix";
      fsType = "ext4";
      neededForBoot = true;
      options = ["noatime"];
    };
    "/run/media/gezaa/HDD01" = {
      device = "/dev/disk/by-label/HDD01";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };
    "/run/media/gezaa/SSD02" = {
      device = "/dev/disk/by-label/SSD02";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };
  };

  # Hostname
  networking.hostName = "desktop-gezaa";

  # Home-Manager
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
          "modules-right" = ["tray" "pulseaudio" "custom/config" "custom/menu"];

          "hyprland/workspaces" = {
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

          "custom/config" = {
            "format" = "";
            "on-click" = "nixos-conf-editor";
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
                    "label": "󰍬",
                    "command": "amixer set Capture toggle"
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
