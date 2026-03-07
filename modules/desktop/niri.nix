{
  pkgs,
  username,
  ...
}:
{
  services = {
    gnome.gnome-keyring.enable = true;
    logind.settings.Login.HandlePowerKey = "ignore";
  };

  systemd = {
    user.services = {
      # Polkit
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };

      cliphist-text = {
        description = "wl-paste + cliphist service for text";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
          Restart = "on-failure";
        };
      };

      cliphist-image = {
        description = "wl-paste + cliphist service for image";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";
          Restart = "on-failure";
        };
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    cliphist
    hyprpicker
    kitty
    playerctl
    wl-clip-persist
    goose-shell
  ];

  programs = {
    niri = {
      enable = true;
      useNautilus = false;
    };

    dconf.enable = true;
    ssh.askPassword = "";
    xwayland.enable = true;
  };

  home-manager.users.${username} =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      services.hypridle.enable = true;

      wayland.windowManager.niri = {
        enable = true;
        settings = {
          prefer-no-csd = [ ];
          hotkey-overlay.skip-at-startup = [ ];
          screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          environment = {
            ELM_DISPLAY = "wl";
            GDK_BACKEND = "wayland,x11";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            SDL_VIDEODRIVER = "wayland,x11";
            CLUTTER_BACKEND = "wayland";
          };

          spawn-at-startup = [
            [
              "wl-clip-persist"
              "--clipboard"
              "regular"
            ]
            [
              "cliphist"
              "wipe"
            ]
            [
              "systemctl"
              "--user"
              "start"
              "cliphist-text.service"
            ]
            [
              "systemctl"
              "--user"
              "start"
              "cliphist-image.service"
            ]
            [
              "systemctl"
              "--user"
              "start"
              "hypridle.service"
            ]
            [ "goose-shell" ]
          ];

          spawn-sh-at-startup = [
            [
              "sleep 4 && goose-shell ipc call networking setBluetoothEnabled false && goose-shell ipc call networking setBluetoothEnabled false"
            ]
            [ "id=0" ]
          ];

          input = {
            disable-power-key-handling = [ ];
            warp-mouse-to-focus = [ ];
            focus-follows-mouse._props.max-scroll-amount = "25%";
            mouse.accel-speed = 0.5;
            touchpad = {
              tap = [ ];
              natural-scroll = [ ];
              accel-speed = 0.5;
            };
            keyboard = {
              numlock = [ ];
              xkb.layout = "de";
            };
          };

          binds = {
            "Alt+Return".toggle-overview = [ ];
            "Alt+H".focus-column-or-monitor-left = [ ];
            "Alt+J".focus-window-or-workspace-down = [ ];
            "Alt+K".focus-window-or-workspace-up = [ ];
            "Alt+L".focus-column-or-monitor-right = [ ];

            "Ctrl+Alt+D".toggle-window-floating = [ ];
            "Ctrl+Alt+F".fullscreen-window = [ ];
            "Ctrl+Alt+L".consume-or-expel-window-right = [ ];
            "Ctrl+Alt+H".consume-or-expel-window-left = [ ];
            "Ctrl+Alt+K".move-window-up-or-to-workspace-up = [ ];
            "Ctrl+Alt+J".move-window-down-or-to-workspace-down = [ ];
            "Ctrl+Alt+Return".move-window-to-monitor-next = [ ];
            "Ctrl+Alt+Q".switch-preset-column-width = [ ];
            "Ctrl+Alt+A".switch-preset-window-height = [ ];
            "Ctrl+Alt+W".maximize-column = [ ];
            "Ctrl+Alt+S".expand-column-to-available-width = [ ];
            "Ctrl+Alt+Tab".toggle-column-tabbed-display = [ ];

            "Alt+1".focus-workspace._args = [ 1 ];
            "Alt+2".focus-workspace._args = [ 2 ];
            "Alt+3".focus-workspace._args = [ 3 ];
            "Alt+4".focus-workspace._args = [ 4 ];
            "Alt+5".focus-workspace._args = [ 5 ];
            "Alt+6".focus-workspace._args = [ 6 ];
            "Alt+7".focus-workspace._args = [ 7 ];
            "Alt+8".focus-workspace._args = [ 8 ];
            "Alt+9".focus-workspace._args = [ 9 ];
            "Alt+0".focus-workspace._args = [ 10 ];

            "Print".screenshot = [ ];
            "XF86PowerOff".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "panelService"
              "togglePowerMenu"
            ];
            "XF86AudioMute".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "volume"
              "toggleMuted"
            ];
            "XF86AudioPlay".spawn = [
              "playerctl"
              "play-pause"
            ];
            "XF86AudioPrev".spawn = [
              "playerctl"
              "previous"
            ];
            "XF86AudioNext".spawn = [
              "playerctl"
              "next"
            ];
            "XF86AudioRaiseVolume".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "volume"
              "increase"
              "5"
            ];
            "XF86AudioLowerVolume".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "volume"
              "decrease"
              "5"
            ];
            "XF86MonBrightnessUp".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "brightness"
              "increase"
              "5"
            ];
            "XF86MonBrightnessDown".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "brightness"
              "decrease"
              "5"
            ];
            "Super+X".close-window = [ ];
            "Super+A".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "panelService"
              "toggleLauncher"
            ]; # launcher
            "Super+L".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "session"
              "lock"
            ]; # lock screen
            "Super+P".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "panelService"
              "togglePowerMenu"
            ]; # power options
            "Super+S".spawn = [
              "goose-shell"
              "ipc"
              "call"
              "panelService"
              "toggleControlCenter"
            ]; # notification hub
            "Super+T".spawn = "kitty"; # terminal
            "Super+C".spawn-sh = [ "pidof hyprpicker || hyprpicker -lar" ]; # color-picker
            "Super+K".spawn-sh = [ "keepassxc ~/secrets/main.kdbx" ];
          };

          gestures.hot-corners.off = [ ];

          layout = {
            gaps = 8;
            default-column-width.proportion = 0.5;
            insert-hint.color = "rgba(224, 224, 224, 30%)";
            border.off = [ ];

            preset-column-widths._children = [
              { proportion = 1.0 / 3.0; }
              { proportion = 0.5; }
              { proportion = 2.0 / 3.0; }
            ];

            preset-window-heights._children = [
              { proportion = 1.0 / 3.0; }
              { proportion = 0.5; }
              { proportion = 2.0 / 3.0; }
              { proportion = 1.0; }
            ];

            focus-ring = {
              width = 2;
              active-color = "#e0e0e0ff";
              inactive-color = "#00000000";
            };

            tab-indicator = {
              place-within-column = [ ];
              width = 8;
              corner-radius = 8;
              gap = 8;
              gaps-between-tabs = 8;
              position = "top";
              active-color = "rgba(224, 224, 224, 100%)";
              inactive-color = "rgba(224, 224, 224, 30%)";
              length._props.total-proportion = 1.0;
            };
          };

          overview.backdrop-color = "#0f0f0f";

          recent-windows.highlight = {
            active-color = "rgba(224, 224, 224, 100%)";
            urgent-color = "rgba(224, 53, 53, 100%)";
            corner-radius = 8;
          };

          window-rule = [
            {
              geometry-corner-radius = 8;
              clip-to-geometry = true;
              draw-border-with-background = false;
            }
            {
              _children = [
                { match._props.app-id = "io.github.kaii_lb.Overskride"; }
                { match._props.app-id = "com.network.manager"; }
                { match._props.app-id = "com.saivert.pwvucontrol"; }
                { match._props.app-id = "io.github.dp0sk.Crosspipe"; }
                { match._props.app-id = "com.github.wwmm.easyeffects"; }
                { match._props.app-id = "wdisplays"; }
              ];
              open-floating = true;
            }
            {
              match._props.is-window-cast-target = true;

              focus-ring = {
                active-color = "rgba(224, 53, 53, 100%)";
                inactive-color = "rgba(224, 53, 53, 30%)";
              };
              tab-indicator = {
                active-color = "rgba(224, 53, 53, 100%)";
                inactive-color = "rgba(224, 53, 53, 30%)";
              };
            }
          ];
        };
      };
    };
}
