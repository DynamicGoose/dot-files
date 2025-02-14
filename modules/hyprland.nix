{ config, pkgs, lib, inputs, ... }: {
  config = {
    services = {
      blueman.enable = true;
      gnome.gnome-keyring.enable = true;
    };
  
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      cliphist
      hypridle
      hyprlock
      hyprpicker
      hyprshot
      kitty
      networkmanagerapplet
      playerctl
      pwvucontrol
      qalculate-gtk
      swaybg
      swaynotificationcenter
      swayosd
      syncthingtray
      wl-clipvoard
      wl-clip-persist
      wofi-power-menu
    ];
    
    programs = {
      dconf.enable = true;
      hyprland.enable = true;
      ssh.askPassword = "";
      xwayland.enable = true;
    };

    home-manager.users.gezaa = { config, ... }: {
      programs = {
        waybar.enable = true;
        wofi.enable = true;
      };
      
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          # monitors configured by host
        
          exec-once = [
            "wl-clip-persist --clipboard regular"
            "cliphist wipe"
            "wl-paste --type text --watch cliphist store"
            "wl-paste --type image --watch cliphist store"
            "waybar"
            "swayosd-server"
            "swaybg -m fill -i ${pkgs.graphite-gtk-theme.override {wallpapers = true;}}/share/backgrounds/wave-Dark.png -o eDP-1"
            "nm-applet"
            "swaync"
            "hypridle"
            "sleep 1 && blueman-applet"
            "sleep 3 && syncthingtray --wait"
            "id=0"
          ];

          general = {
            gaps_in = 3;
            gaps_out = 6;
            border_size = 2;
            resize_on_border = true;
            layout = "master";
            "col.active_border" = "rgba(e0e0e0ff)";
            "col.inactive_border" = "rgba(00000000)";
          };

          decoration = {
            active_opacity = 1.0;
            inactive_opacity = 1.0;
            fullscreen_opacity = 1.0;
            rounding = 8;

            blur = {
              enabled = true;
              size = 8;
              passes = 1;
              ignore_opacity = false;
              new_optimizations = true;
            };

            shadow = {
              enabled = false;
            };
          };

          animations = {
            enabled = true;

            bezier = [
              "overshot, 0.05, 0.9, 0.1, 1.05"
              "fade, 0, 0, 0, 1"
              "layersin, 0.215, 0.61, 0.355, 1"
              "layersout, 0.55, 0.055, 0.675, 0.19"
            ];

            animation = [
              "windows, 1, 7, overshot"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "fade, 1, 7, fade"
              "workspaces, 1, 6, default"
              "layersIn, 1, 4, layersin"
              "layersOut, 1, 4, layersout"
            ];
          };

          master = {
            new_status = "inherit";
          };

          input = {
            kb_layout = "de";
            scroll_method = "2fg";
            follow_mouse = 1;
            numlock_by_default = true;
            sensitivity = 0.5;

            touchpad = {
              natural_scroll = true;
              disable_while_typing = false;
              tap-to-click = true;
            };
          };

          gestures = {
            workspace_swipe = true;
          };

          misc = {
            disable_hyprland_logo = true;
            vfr = true;
            enable_swallow = true;
            swallow_regex = "^(kitty)$";
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;
          };

          windowrule = [
            "float, .blueman-manager-wrapped"
            "float, nm-connection-editor"
            "float, com.saivert.pwvucontrol"
            "float, wdisplays"
            "float, cpupower-gui"
            "float, qalculate-gtk"
            "center (1), .blueman-manager-wrapped"
            "center (1), nm-connection-editor"
            "center (1), com.saivert.pwvucontrol"
            "center (1), wdisplays"
            "center (1), cpupower-gui"
            "center (1), qalculate-gtk"
            "size 60% 60%, .blueman-manager-wrapped"
            "size 60% 60%, nm-connection-editor"
            "size 60% 60%, com.saivert.pwvucontrol"
            "size 60% 60%, wdisplays"
            "size 60% 60%, cpupower-gui"
          ];

          windowrulev2 = [
            "opacity 0.0 override 0.0 override, class: ^(xwaylandvideobridge)$"
            "noanim, class:^(xwaylandvideobridge)$"
            "nofocus, class:^(xwaylandvideobridge)$"
            "noinitialfocus, class:^(xwaylandvideobridge)$"
            "float, title:(Steam Settings)"
            "float, title:(Syncthing Tray)"
            "center (1), title:(Syncthing Tray)"
            "size 60% 60%, title:(Syncthing Tray)"
          ];

          bind = [          
            ", Print, exec, hyprshot -o ~/Pictures/Screenshots -m region"
            "SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
            "CTRL_ALT, C, exec, hyprpicker --autocopy"
            "SUPER, C, exec, qalculate-gtk"
            "ALT, X, killactive,"
            "ALT, F, togglefloating,"
            "SUPER, F, fullscreen,"
            "CTRL_ALT, T, exec, kitty"
            "SUPER, A, exec, pidof wofi || wofi"
            "SUPER_ALT, L, exec, hyprlock"
            "SUPER_ALT, P, exec, pidof wofi-power-menu || wofi-power-menu"
            "ALT, comma, splitratio, -0.05"
            "ALT, period, splitratio, +0.05"
            "ALT, left, movefocus, l"
            "ALT, right, movefocus, r"
            "ALT, up, movefocus, u"
            "ALT, down, movefocus, d"
            "ALT_CTRL, left, movewindow, l"
            "ALT_CTRL, right, movewindow, r"
            "ALT_CTRL, up, movewindow, u"
            "ALT_CTRL, down, movewindow, d"
            "ALT, 1, workspace, 1"
            "ALT, 2, workspace, 2"
            "ALT, 3, workspace, 3"
            "ALT, 4, workspace, 4"
            "ALT, 5, workspace, 5"
            "ALT, 6, workspace, 6"
            "ALT, 7, workspace, 7"
            "ALT, 8, workspace, 8"
            "ALT, 9, workspace, 9"
            "ALT, 0, workspace, 10"
            "ALT_SUPER, left, workspace, e-1"
            "ALT_SUPER, right, workspace, e+1"
            "ALT_CTRL, 1, movetoworkspace, 1"
            "ALT_CTRL, 2, movetoworkspace, 2"
            "ALT_CTRL, 3, movetoworkspace, 3"
            "ALT_CTRL, 4, movetoworkspace, 4"
            "ALT_CTRL, 5, movetoworkspace, 5"
            "ALT_CTRL, 6, movetoworkspace, 6"
            "ALT_CTRL, 7, movetoworkspace, 7"
            "ALT_CTRL, 8, movetoworkspace, 8"
            "ALT_CTRL, 9, movetoworkspace, 9"
            "ALT_CTRL, 0, movetoworkspace, 10"
            "ALT, mouse_down, workspace, e+1"
            "ALT, mouse_up, workspace, e-1"
            ", XF86PowerOff, exec, pidof wofi-power-menu || wofi-power-menu"
            ", XF86AudioMute, exec, swayosd-client --output-volume=mute-toggle"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPrev, exec, playerctl previous"
            ", XF86AudioNext, exec, playerctl next"
          ];

          binde = [
            ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume=raise"
            ", XF86AudioLowerVolume, exec, swayosd-client --output-volume=lower"
            ", XF86MonBrightnessUp, exec, swayosd-client --brightness=raise"
            ", XF86MonBrightnessDown, exec, swayosd-client --brightness=lower"
          ];

          bindm = [
            "ALT, mouse:272, movewindow"
            "ALT, mouse:273, resizewindow"
          ];

          bindr = [
            "SUPER, SUPER_L, exec, swaync-client -t"
          ];

          layerrule = [
            "animation slide right, swaync-control-center"
            "animation slide right, swaync-notification-window"
          ];
        };
      }
    };
  };
}
