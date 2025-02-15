{ config, pkgs, lib, inputs, ... }: {
  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    logind.powerKey = "ignore";
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
    user.services.niri-flake-polkit.enable = false;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  nixpkgs.overlays = [inputs.niri.overlays.niri];

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
    qalculate-gtk
    swaybg
    swaynotificationcenter
    swayosd
    syncthingtray
    uwsm
    wl-clipboard
    wl-clip-persist
    wofi-power-menu
    xwayland-satellite
  ];
  
  programs = {
    dconf.enable = true;
    niri.enable = true;
    ssh.askPassword = "";
    xwayland.enable = true;
  };

  home-manager.users.${config.modules.users.username} = { pkgs, config, ... }: {
    services.hypridle.enable = true;
    programs = {
      waybar.enable = true;
      wofi.enable = true;
      
      niri = {
        settings = {
          prefer-no-csd = true;
          hotkey-overlay.skip-at-startup = true;

          environment = {
            DISPLAY = ":1";
            ELM_DISPLAY = "wl";
            GDK_BACKEND = "wayland,x11";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            SDL_VIDEODRIVER = "wayland";
            CLUTTER_BACKEND = "wayland";
          };

          spawn-at-startup = let
            sh = ["sh" "-c"];
          in [
            { command = sh ++ ["uwsm app -- wl-clip-persist --clipboard regular"]; }
            { command = sh ++ ["cliphist wipe"]; }
            { command = sh ++ ["uwsm app -- wl-paste --watch cliphist store"]; }
            { command = sh ++ ["systemctl --user start hypridle.service"]; }
            { command = sh ++ ["uwsm app -- waybar"]; }
            { command = sh ++ ["uwsm app -- swayosd-server"]; }
            { command = sh ++ ["uwsm app -- swaybg -m fill -i ${pkgs.graphite-gtk-theme.override {wallpapers = true;}}/share/backgrounds/wave-Dark.png"]; }
            { command = sh ++ ["uwsm app -- nm-applet"]; }
            { command = sh ++ ["uwsm app -- swaync"]; }
            { command = sh ++ ["uwsm app -- sleep 1 && blueman-applet"]; }
            { command = sh ++ ["uwsm app -- sleep 3 && syncthingtray --wait"]; }
            { command = sh ++ ["id=0"]; }
            { command = sh ++ ["uwsm app -- xwayland-satellite"]; }
          ];
        
          input = {
            power-key-handling.enable = false;
            warp-mouse-to-focus = true;

            mouse = {
              accel-speed = 0.5;
            };
          
            touchpad = {
              accel-speed = 0.5;
            };
          
            keyboard.xkb = {
              layout = "de";
            };

            focus-follows-mouse = {
              enable = true;
              max-scroll-amount = "0%";
            };
          };

          binds = with config.lib.niri.actions; let
            sh = spawn "sh" "-c";
          in {
            "Alt+X".action = close-window;
            "Alt+F".action = toggle-window-floating;
            "Super+F".action = fullscreen-window;
          
            "Alt+Right".action = focus-column-or-monitor-right;
            "Alt+Left".action = focus-column-or-monitor-left;
            "Alt+Up".action = focus-window-or-monitor-up;
            "Alt+Down".action = focus-window-or-monitor-down;

            "Ctrl+Alt+Right".action = consume-or-expel-window-right;
            "Ctrl+Alt+Left".action = consume-or-expel-window-left;
            "Ctrl+Alt+Up".action = move-window-up-or-to-workspace-up;
            "Ctrl+Alt+Down".action = move-window-down-or-to-workspace-down;

            "Ctrl+Alt+Q".action = switch-preset-column-width;
            "Ctrl+Alt+A".action = switch-preset-window-height;
            "Ctrl+Alt+W".action = maximize-column;
            "Ctrl+Alt+Tab".action = move-window-to-monitor-next;

            "Alt+Super+Up".action = focus-workspace-up;
            "Alt+Super+Down".action = focus-workspace-down;
            "Alt+1".action = focus-workspace 1;
            "Alt+2".action = focus-workspace 2;
            "Alt+3".action = focus-workspace 3;
            "Alt+4".action = focus-workspace 4;
            "Alt+5".action = focus-workspace 5;
            "Alt+6".action = focus-workspace 6;
            "Alt+7".action = focus-workspace 7;
            "Alt+8".action = focus-workspace 8;
            "Alt+9".action = focus-workspace 9;
            "Alt+0".action = focus-workspace 10;

            "Print".action = sh "pidof hyprshot || hyprshot -o ~/Pictures/Screenshots -m region";
            "Super+V".action = sh "cliphist list | wofi -S dmenu | cliphist decode | wl-copy";
            "Ctrl+Alt+C".action = sh "pidof hyprpicker || hyprpicker --autocopy";
            "Super+C".action = spawn "qalculate-gtk";
            "Ctrl+Alt+T".action = spawn "kitty";
            "Super+A".action = sh "pidof wofi || wofi";
            "Super+S".action = sh "swaync-client -t";
            "Super+Alt+L".action = sh "loginctl lock-session";
            "Super+Alt+P".action = sh "pidof wofi-power-menu || wofi-power-menu";
            "XF86PowerOff".action = sh "pidof wofi-power-menu || wofi-power-menu";
            "XF86AudioMute".action = sh "swayosd-client --output-volume=mute-toggle";
            "XF86AudioPlay".action = sh "playerctl play-pause";
            "XF86AudioPrev".action = sh "playerctl previous";
            "XF86AudioNext".action = sh "playerctl next";
            "XF86AudioRaiseVolume".action = sh "swayosd-client --output-volume=raise";
            "XF86AudioLowerVolume".action = sh "swayosd-client --output-volume=lower";
            "XF86MonBrightnessUp".action = sh "swayosd-client --brightness=raise";
            "XF86MonBrightnessDown".action = sh "swayosd-client --brightness=lower";
          };

          layout = {
            border.enable = false;
            gaps = 8;
            default-column-width.proportion = 0.5;
            insert-hint.display = { color = "rgba(224, 224, 224, 30%)"; };

            preset-column-widths = [
              { proportion = 1.0 / 3.0; }
              { proportion = 0.5; }
              { proportion = 2.0 / 3.0; }
            ];

            preset-window-heights = [
              { proportion = 1.0 / 3.0; }
              { proportion = 0.5; }
              { proportion = 2.0 / 3.0; }
            ];
           
            focus-ring = {
              enable = true;
              width = 2;
              active = { color = "#e0e0e0ff"; };
              inactive = { color = "#00000000"; };
            };
          };

          window-rules = [
            {
              geometry-corner-radius = let
                radius = 8.0;
              in {
                bottom-left = radius;
                bottom-right = radius;
                top-left = radius;
                top-right = radius;
              };
              clip-to-geometry = true;
              draw-border-with-background = false;
            }
            {
              matches = [
                { app-id = ".blueman-manager-wrapped"; }
                { app-id = "nm-connection-editor"; }
                { app-id = "com.saivert.pwvucontrol"; }
                { app-id = "wdisplays"; }
                { app-id = "qalculate-gtk"; }
                { title = "Syncthing Tray"; }
              ];
              open-floating = true;
            }
          ];
        };
      };
    };
  };
}
