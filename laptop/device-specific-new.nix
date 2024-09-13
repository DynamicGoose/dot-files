{ inputs, config, pkgs, ... }:
{
  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  # Host name
  networking.hostname = "tp-e490";

  # Power management
  sevices.cpupower-gui.enable = true;
  services.tlp.enable = true;

  # Graphics drivers
  hardware.graphics. extraPackages = with pkgs; [
    intel-media-sdk
    intel-media-driver
    intel-vaapi-driver
    libvdpau-va-gl
  ];
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # Home-manager
  home-manager.users.gezaa = { pkgs, ... }: {
    # Hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        monitor = , preferred, auto, 1

        exec-once = xwaylandvideobridge
        exec-once = wl-clip-persist --clipboard both
        exec-once = cliphist wipe
        exec-once = wl-paste --type text --watch cliphist store
        exec-once = wl-paste --type image --watch cliphist store
        exec-once = hypridle
        exec-once = waybar
        exec-once = swayosd-server
        exec-once = swaybg -m fill -i ${pkgs.budgie.budgie-backgrounds}/share/backgrounds/budgie/saturnian-profile.jpg -o eDP-1
        exec-once = nm-applet
        exec-once = swaync
        exec-once = sleep 1 && blueman-applet
        exec-once = sleep 3 && qsyncthingtray
        exec-once = id=0

        input {
          kb_layout = de
          scroll_method = 2fg
          follow_mouse = 1
          numlock_by_default = true

          touchpad {
            natural_scroll = true
            disable_while_typing = false
            tap-to-click = true
          }

          sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification
        }

        general {
          gaps_in = 3
          gaps_out = 6
          border_size = 2
          resize_on_border = false
          col.active_border = rgba(e0e0e0ff)
          col.inactive_border = rgba(00000000)
          layout = master
        }

        decoration {
          active_opacity = 1.0
          inactive_opacity = 1.0
          fullscreen_opacity = 1.0
          rounding = 8

          blur {
            enabled = true
            size = 8
            passes = 1
            ignore_opacity = false
            new_optimizations = true
          }

          drop_shadow = false
        }

        animations {
          enabled = true

          bezier = overshot, 0.05, 0.9, 0.1, 1.05
          bezier = fade, 0, 0, 0, 1

          animation = windows, 1, 7, overshot
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 7, fade
          animation = workspaces, 1, 6, default
        }

        master {
          new_status = inherit
        }

        gestures {
          workspace_swipe = true
        }

        misc {
          disable_hyprland_logo = true
          vfr = true
          enable_swallow = true
          swallow_regex = ^(kitty)$
          mouse_move_enables_dpms = true
          mouse_press_enables_dpms = true
        }

        # Window Rules
        windowrule = float, title:^(Bluetooth Devices)
        windowrule = float, title:^(Network Connections)
        windowrule = float, title:^(Volume Control)
        windowrule = float, title:(wdisplays)
        windowrule = float, title:(cpupower-gui)
        windowrule = float, qalculate-gtk
        
        windowrule = center (1), title:^(Bluetooth Devices)
        windowrule = center (1), title:^(Network Connections)
        windowrule = center (1), title:^(Volume Control)
        windowrule = center (1), title:(wdisplays)
        windowrule = center (1), title:(cpupower-gui)
        windowrule = center (1), qalculate-gtk
        
        windowrule = size 60% 60%, title:^(Bluetooth Devices)
        windowrule = size 60% 60%, title:^(Network Connections)
        windowrule = size 60% 60%, title:^(Volume Control)
        windowrule = size 60% 60%, title:(wdisplays)
        windowrule = size 60% 60%, title:(cpupower-gui)

        windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
        windowrulev2 = noanim,class:^(xwaylandvideobridge)$
        windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
        windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

        # Binds
        bind = SUPER, D, hyprexpo:expo, toggle
        bind = , Print, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%s_grim.png') && wl-copy < ~/Pictures/Screenshots/$(date +'%s_grim.png')
        bind = SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy
        bind = CTRL_ALT, C, exec, hyprpicker --autocopy
        bind = SUPER, C, exec, qalculate-gtk
        bind = ALT, X, killactive,  
        bind = ALT, F, togglefloating, 
        bind = SUPER, F, fullscreen,
        bind = CTRL_ALT, T, exec, kitty
        bind = SUPER, A, exec, wofi
        bind = SUPER_ALT, L, exec, hyprlock
        bind = SUPER_ALT, P, exec, wlogout
        bind = ALT, comma, splitratio, -0.05
        bind = ALT, period, splitratio, +0.05

        # Move focus with alt + arrow keys
        bind = ALT, left, movefocus, l
        bind = ALT, right, movefocus, r
        bind = ALT, up, movefocus, u
        bind = ALT, down, movefocus, d
        bind = ALT_CTRL, left, movewindow, l
        bind = ALT_CTRL, right, movewindow, r
        bind = ALT_CTRL, up, movewindow, u
        bind = ALT_CTRL, down, movewindow, d

        # Switch workspaces with alt + [0-9]
        bind = ALT, 1, workspace, 1
        bind = ALT, 2, workspace, 2
        bind = ALT, 3, workspace, 3
        bind = ALT, 4, workspace, 4
        bind = ALT, 5, workspace, 5
        bind = ALT, 6, workspace, 6
        bind = ALT, 7, workspace, 7
        bind = ALT, 8, workspace, 8
        bind = ALT, 9, workspace, 9
        bind = ALT, 0, workspace, 10
        bind = ALT_SUPER, left, workspace, e-1
        bind = ALT_SUPER, right, workspace, e+1

        # Move active window to a workspace with ALT + CTRL + [0-9]
        bind = ALT_CTRL, 1, movetoworkspace, 1
        bind = ALT_CTRL, 2, movetoworkspace, 2
        bind = ALT_CTRL, 3, movetoworkspace, 3
        bind = ALT_CTRL, 4, movetoworkspace, 4
        bind = ALT_CTRL, 5, movetoworkspace, 5
        bind = ALT_CTRL, 6, movetoworkspace, 6
        bind = ALT_CTRL, 7, movetoworkspace, 7
        bind = ALT_CTRL, 8, movetoworkspace, 8
        bind = ALT_CTRL, 9, movetoworkspace, 9
        bind = ALT_CTRL, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
        bind = ALT, mouse_down, workspace, e+1
        bind = ALT, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = ALT, mouse:272, movewindow
        bindm = ALT, mouse:273, resizewindow

        # Funtion keys
        binde = , XF86AudioRaiseVolume, exec, swayosd-client --output-volume=raise
        binde = , XF86AudioLowerVolume, exec, swayosd-client --output-volume=lower
        bind = , XF86AudioMute, exec, swayosd-client --output-volume=mute-toggle
        binde = , XF86MonBrightnessUp, exec, swayosd-client --brightness=raise
        binde = , XF86MonBrightnessDown, exec, swayosd-client --brightness=lower

        plugin {
          hyprexpo {
            columns = 3
            gap_size = 8
            bg_col = rgb(000000)

            enable_gesture = true # laptop touchpad
            gesture_fingers = 3 # 3 or 4
            gesture_distance = 300 # how far is the "max"
            gesture_positive = true # positive = swipe down. Negative = swipe up.                
          }
        }
      '';
    };
    
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
          "modules-left" = [ "clock" "hyprland/workspaces" ];
          "modules-center" = [ "hyprland/window" ];
          "modules-right" = [ "tray" "pulseaudio" "backlight" "battery" "custom/menu"];

          "hyprland/workspaces" = {
            "on-click" = "activate";
            "sort-by-number" = true;
            "all-outputs" = true;
            "active-only" = false;
          };

          "backlight" = {
            "format" = "{icon} {percent}%";
            "format-icons" = [ "󰃞" "󰃟" "󰃠" ];
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
            "on-click" = "pavucontrol";
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

    # Swaync
    services.swaync = {
      enable = true;
      settings = {
        $schema = "/etc/xdg/swaync/configSchema.json";
        positionX = "right";
        positionY = "top";
        control-center-margin-top": 6,
        control-center-margin-bottom": 6,
        control-center-margin-right": 6,
        control-center-margin-left": 6,
        notification-icon-size": 64,
        notification-body-image-height": 100,
        notification-body-image-width": 200,
        timeout": 10,
        timeout-low": 5,
        timeout-critical": 0,
        fit-to-screen": true,
        notification-window-width": 500,
        keyboard-shortcuts": true,
        image-visibility": "when-available",
        transition-time": 200,
        hide-on-clear": false,
        hide-on-action": true,
        script-fail-notify": true,
        widgets": [
          buttons-grid",
          mpris",
          volume",
          backlight",
          title",
          dnd",
          notifications"
        ],
        widget-config": {
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
                "label": "󰌾",
                "command": "hyprlock"
              },
              {
                        "label": "󰍃",
                        "command": "killall -u gezaa"
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
    
    }
    };
  };
}
