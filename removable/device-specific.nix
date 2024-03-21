{ inputs, config, pkgs, ... }:
{
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

  services.cpupower-gui.enable = true;

  # Host name
  networking.hostName = "usb-gezaa";

  home-manager.users.gezaa = { pkgs, ...}: {
    # Hyprland
    wayland.windowManager.hyprland = {
      enable = true;

      extraConfig = ''
        monitor=,preferred,auto,1

        exec-once = xwaylandvideobridge
        exec-once = wl-clip-persist --clipboard both
        exec-once = wl-paste --type text --watch cliphist store
        exec-once = wl-paste --type image --watch cliphist store
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
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
          scroll_method = 2fg
          follow_mouse = 1
          numlock_by_default = true

          touchpad {
            natural_scroll = true
            disable_while_typing = false
            tap-to-click = true
          }

          sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.
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
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
        }

        animations {
          enabled = yes

          bezier = overshot, 0.05, 0.9, 0.1, 1.05
          bezier = fade, 0, 0, 0, 1

          animation = windows, 1, 7, overshot
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = fade, 1, 7, fade
          animation = workspaces, 1, 6, default
        }

        master {
          new_is_master = true
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
          key_press_enables_dpms = true
        }

        # Window Rules
        windowrule = float, title:^(Bluetooth Devices)
        windowrule = float, title:^(Network Connections)
        windowrule = float, title:^(Volume Control)
        windowrule = float, title:^(Syncthing Tray)
        windowrule = float, title:(wdisplays)
        windowrule = float, title:(cpupower-gui)
        windowrule = float, qalculate-gtk
        
        windowrule = center (1), title:^(Bluetooth Devices)
        windowrule = center (1), title:^(Network Connections)
        windowrule = center (1), title:^(Volume Control)
        windowrule = center (1), title:^(Syncthing Tray)
        windowrule = center (1), title:(wdisplays)
        windowrule = center (1), title:(cpupower-gui)
        windowrule = center (1), qalculate-gtk
        
        windowrule = size 60% 60%, title:^(Bluetooth Devices)
        windowrule = size 60% 60%, title:^(Network Connections)
        windowrule = size 60% 60%, title:^(Volume Control)
        windowrule = size 60% 60%, title:^(Syncthing Tray)
        windowrule = size 60% 60%, title:(wdisplays)
        windowrule = size 60% 60%, title:(cpupower-gui)

        windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
        windowrulev2 = noanim,class:^(xwaylandvideobridge)$
        windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
        windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

        # Binds
        bind = , Print, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%s_grim.png') && wl-copy < ~/Pictures/Screenshots/$(date +'%s_grim.png')
        bind = SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy
        bind = CTRL_ALT, C, exec, hyprpicker --autocopy
        bind = SUPER, C, exec, qalculate-gtk
        bind = ALT, X, killactive,  
        bind = ALT, F, togglefloating, 
        bind = SUPER, F, fullscreen,
        bind = CTRL_ALT, T, exec, kitty
        bind = SUPER, A, exec, wofi
        bind = SUPER_ALT, L, exec, swaylock --screenshots --clock --indicator --effect-blur 8x8 --text-color ffffff --indicator-radius 200 --inside-color 00000000 --key-hl-color 00000000 --ring-color 00000000 --line-color 00000000 --separator-color 00000000 --text-ver-color ffffff --inside-ver-color 00000000 --ring-ver-color 00000000 --line-ver-color 00000000 --text-wrong-color cf4a4a --inside-wrong-color 00000000 --ring-wrong-color 00000000 --line-wrong-color 00000000 --text-clear-color 4acf4a --inside-clear-color 00000000 --ring-clear-color 00000000 --line-clear-color 00000000
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
        binde = , XF86AudioRaiseVolume, exec, swayosd --output-volume=raise
        binde = , XF86AudioLowerVolume, exec, swayosd --output-volume=lower
        bind = , XF86AudioMute, exec, swayosd --output-volume=mute-toggle
        binde = , XF86MonBrightnessUp, exec, brightnessctl s 5%+
        # swayosd --brightness=raise
        binde = , XF86MonBrightnessDown, exec, brightnessctl s 5%-
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
        '';
      };
      "swaync-style" = {
        enable = true;
        target = "swaync/style.css";
        text = ''
            @define-color cc-bg rgba(15, 15, 15, 1);
            @define-color noti-border-color rgba(224, 224, 224, 1);
            @define-color noti-bg rgb(15, 15, 15);
            @define-color noti-bg-darker rgb(15, 15, 15);
            @define-color noti-bg-hover rgb(34, 34, 34);
            @define-color noti-bg-focus rgba(56, 56, 56, 1);
            @define-color noti-close-bg rgba(56, 56, 56, 1);
            @define-color noti-close-bg-hover rgba(75, 75, 75, 1);
            @define-color text-color rgba(255, 255, 255, 1);
            @define-color text-color-disabled rgb(150, 150, 150);
            @define-color bg-selected rgb(224, 224, 224);

            .control-center .notification-row:focus,
            .control-center .notification-row:hover {
                opacity: 1;
                background: @noti-bg-darker
            }

            .notification-row {
                outline: none;
            }

            .notification {
                border-radius: 10px;
                margin: 6px;
                padding: 0;
                border: 2px solid @noti-border-color
            }

            .notification-content {
                background: transparent;
                padding: 8px;
                border-radius: 10px
            }

            .close-button {
                background: @noti-close-bg;
                color: @text-color;
                text-shadow: none;
                padding: 0;
                border-radius: 100%;
                margin-top: 10px;
                margin-right: 10px;
                box-shadow: none;
                border: none;
                min-width: 24px;
                min-height: 24px
            }

            .close-button:hover {
                box-shadow: none;
                background: @noti-close-bg-hover;
                transition: all .15s ease-in-out;
                border: none
            }

            .notification-default-action,
            .notification-action {
                padding: 4px;
                margin: 0;
                box-shadow: none;
                background: @noti-bg;
                border: none;
                color: @text-color;
                transition: all .15s ease-in-out
            }

            .notification-default-action:hover,
            .notification-action:hover {
                -gtk-icon-effect: none;
                background: @noti-bg-hover
            }

            .notification-default-action {
                border-radius: 10px
            }

            .notification-default-action:not(:only-child) {
                border-bottom-left-radius: 0;
                border-bottom-right-radius: 0
            }

            .notification-action {
                border-radius: 0;
                border-top: none;
                border-right: none
            }

            .notification-action:first-child {
                border-bottom-left-radius: 6px;
                background: @noti-bg-hover
            }

            .notification-action:last-child {
                border-bottom-right-radius: 6px;
                background: @noti-bg-hover
            }

            .inline-reply {
                margin-top: 8px
            }

            .inline-reply-entry {
                background: @noti-bg-darker;
                color: @text-color;
                caret-color: @text-color;
                border: 2px solid @noti-border-color;
                border-radius: 10px
            }

            .inline-reply-button {
                margin-left: 4px;
                background: @noti-bg;
                border: 2px solid @noti-border-color;
                border-radius: 10px;
                color: @text-color
            }

            .inline-reply-button:disabled {
                background: initial;
                color: @text-color-disabled;
                border: 1px solid transparent
            }

            .inline-reply-button:hover {
                background: @noti-bg-hover
            }

            .body-image {
                margin-top: 6px;
                background-color: #fff;
                border-radius: 10px
            }

            .summary {
                font-size: 16px;
                font-weight: bold;
                background: transparent;
                color: @text-color;
                text-shadow: none
            }

            .time {
                font-size: 16px;
                font-weight: bold;
                background: transparent;
                color: @text-color;
                text-shadow: none;
                margin-right: 18px
            }

            .body {
                font-size: 15px;
                font-weight: 400;
                background: transparent;
                color: @text-color;
                text-shadow: none
            }

            .control-center {
                background: @cc-bg;
                border: 2px solid @noti-border-color;
                border-radius: 10px;
            }

            .control-center-list {
                background: transparent
            }

            .control-center-list-placeholder {
                opacity: .5
            }

            .floating-notifications {
                background: transparent
            }

            .blank-window {
                background: alpha(black, 0)
            }

            .widget-title {
                color: @text-color;
                margin: 8px;
                font-size: 1.5rem
            }

            .widget-title>button {
                font-size: initial;
                color: @text-color;
                text-shadow: none;
                background: @noti-bg;
                border: 2px solid @noti-border-color;
                box-shadow: none;
                border-radius: 10px
            }

            .widget-title>button:hover {
                background: @noti-bg-hover
            }

            .widget-dnd {
                color: @text-color;
                margin: 8px;
                font-size: 1.1rem
            }

            .widget-dnd>switch {
                font-size: initial;
                border-radius: 10px;
                background: @noti-bg;
                border: 2px solid @noti-border-color;
                box-shadow: none
            }

            .widget-dnd>switch:checked {
                background: @bg-selected
            }

            .widget-dnd>switch slider {
                background: @noti-bg-hover;
                border-radius: 10px
            }

            .widget-label {
                margin: 8px;
            }

            .widget-label>label {
                font-size: 1.5rem;
                color: @text-color;
            }

            .widget-mpris {
                color: @text-color;
                background: @noti-bg-darker;
                padding: 8px;
                margin: 0px;
            }

            .widget-mpris-player {
                padding: 8px;
                margin: 8px
            }

            .widget-mpris-title {
                font-weight: 700;
                font-size: 1.25rem
            }

            .widget-mpris-subtitle {
                font-size: 1.1rem
            }

            .widget-buttons-grid {
                font-size: x-large;
                padding: 8px;
                margin: 0px;
                background: @noti-bg-darker;
            }

            .widget-buttons-grid>flowbox>flowboxchild>button {
                margin: 8px;
                background: @noti-bg;
                border-radius: 10px;
                color: @text-color
            }

            .widget-buttons-grid>flowbox>flowboxchild>button:hover {
                background: @noti-bg-hover;
                color: @noti-border-color
            }

            .widget-menubar>box>.menu-button-bar>button {
                border: none;
                background: transparent
            }

            .topbar-buttons>button {
                border: none;
                background: transparent
            }

            .widget-volume {
                background: @noti-bg-darker;
                padding: 8px;
                margin: 0px;
                border-radius: 10px;
                font-size: x-large;
                color: @noti-border-color
            }

            .widget-volume>box>button {
                background: transparent;
                border: none
            }

            .per-app-volume {
                background-color: @noti-bg;
                padding: 4px 8px 8px;
                margin: 0 8px 8px;
                border-radius: 10px
            }

            .widget-backlight {
                background: @noti-bg-darker;
                padding: 8px;
                margin: 0px;
                border-radius: 0px;
                font-size: x-large;
                color: @noti-border-color
            }

            .widget-inhibitors {
                margin: 8px;
                font-size: 1.5rem
            }

            .widget-inhibitors>button {
                font-size: initial;
                color: @text-color;
                text-shadow: none;
                background: @noti-bg;
                border: 2px solid @noti-border-color;
                box-shadow: none;
                border-radius: 10px
            }

            .widget-inhibitors>button:hover {
                background: @noti-bg-hover
            }
        '';
      };
    };
  };
}
