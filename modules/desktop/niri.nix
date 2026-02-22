{
  pkgs,
  inputs,
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
      niri-flake-polkit.enable = false;

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

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  niri-flake.cache.enable = false;

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
      package = pkgs.niri;
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
      programs = {
        niri = {
          settings = {
            prefer-no-csd = true;
            hotkey-overlay.skip-at-startup = true;
            screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";
            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

            environment = {
              ELM_DISPLAY = "wl";
              GDK_BACKEND = "wayland,x11";
              QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
              SDL_VIDEODRIVER = "wayland,x11";
              CLUTTER_BACKEND = "wayland";
            };

            spawn-at-startup =
              let
                sh = [
                  "sh"
                  "-c"
                ];
              in
              [
                { command = sh ++ [ "wl-clip-persist --clipboard regular" ]; }
                { command = sh ++ [ "cliphist wipe" ]; }
                { command = sh ++ [ "systemctl --user start cliphist-text.service" ]; }
                { command = sh ++ [ "systemctl --user start cliphist-image.service" ]; }
                { command = sh ++ [ "systemctl --user start hypridle.service" ]; }
                { command = [ "goose-shell" ]; }
                { command = sh ++ [ "sleep 4 && goose-shell ipc call networking setBluetoothEnabled false && goose-shell ipc call networking setBluetoothEnabled false" ]; } # disable bluetooth on startup, call 2 times warum auch immer
                { command = sh ++ [ "id=0" ]; }
              ];

            input = {
              power-key-handling.enable = false;
              warp-mouse-to-focus.enable = true;

              mouse = {
                accel-speed = 0.5;
              };

              touchpad = {
                accel-speed = 0.5;
              };

              keyboard = {
                numlock = true;
                xkb.layout = "de";
              };

              focus-follows-mouse = {
                enable = true;
                max-scroll-amount = "25%";
              };
            };

            binds =
              with config.lib.niri.actions;
              let
                sh = spawn "sh" "-c";
              in
              {
                "Alt+Return".action = toggle-overview;
                "Alt+H".action = focus-column-or-monitor-left;
                "Alt+J".action = focus-window-or-workspace-down;
                "Alt+K".action = focus-window-or-workspace-up;
                "Alt+L".action = focus-column-or-monitor-right;

                "Ctrl+Alt+D".action = toggle-window-floating;
                "Ctrl+Alt+F".action = fullscreen-window;
                "Ctrl+Alt+L".action = consume-or-expel-window-right;
                "Ctrl+Alt+H".action = consume-or-expel-window-left;
                "Ctrl+Alt+K".action = move-window-up-or-to-workspace-up;
                "Ctrl+Alt+J".action = move-window-down-or-to-workspace-down;
                "Ctrl+Alt+Return".action = move-window-to-monitor-next;
                "Ctrl+Alt+Q".action = switch-preset-column-width;
                "Ctrl+Alt+A".action = switch-preset-window-height;
                "Ctrl+Alt+W".action = maximize-column;
                "Ctrl+Alt+S".action = expand-column-to-available-width;
                "Ctrl+Alt+Tab".action = toggle-column-tabbed-display;

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

                "Print".action.screenshot = [ ];
                "XF86PowerOff".action = sh "goose-shell ipc call panelService togglePowerMenu";
                "XF86AudioMute".action = sh "goose-shell ipc call volume toggleMuted";
                "XF86AudioPlay".action = sh "playerctl play-pause";
                "XF86AudioPrev".action = sh "playerctl previous";
                "XF86AudioNext".action = sh "playerctl next";
                "XF86AudioRaiseVolume".action = sh "goose-shell ipc call volume increase 5";
                "XF86AudioLowerVolume".action = sh "goose-shell ipc call volume decrease 5";
                "XF86MonBrightnessUp".action = sh "goose-shell ipc call brightness increase 5";
                "XF86MonBrightnessDown".action = sh "goose-shell ipc call brightness decrease 5";
                "Super+X".action = close-window;
                "Super+A".action = sh "goose-shell ipc call panelService toggleLauncher"; # launcher
                "Super+L".action = sh "goose-shell ipc call session lock"; # lock screen
                "Super+P".action = sh "goose-shell ipc call panelService togglePowerMenu"; # power options
                "Super+S".action = sh "goose-shell ipc call panelService toggleControlCenter"; # notification hub
                "Super+T".action = spawn "kitty"; # terminal
                "Super+C".action = sh "pidof hyprpicker || hyprpicker -lar"; # color-picker
              };

            gestures.hot-corners.enable = false;

            layout = {
              gaps = 8;
              default-column-width.proportion = 0.5;
              insert-hint.display = {
                color = "rgba(224, 224, 224, 30%)";
              };

              preset-column-widths = [
                { proportion = 1.0 / 3.0; }
                { proportion = 0.5; }
                { proportion = 2.0 / 3.0; }
              ];

              preset-window-heights = [
                { proportion = 1.0 / 3.0; }
                { proportion = 0.5; }
                { proportion = 2.0 / 3.0; }
                { proportion = 1.0; }
              ];

              border.enable = false;

              focus-ring = {
                enable = true;
                width = 2;
                active = {
                  color = "#e0e0e0ff";
                };
                inactive = {
                  color = "#00000000";
                };
              };

              tab-indicator = {
                enable = true;
                place-within-column = true;
                width = 8;
                corner-radius = 8;
                gap = 8;
                gaps-between-tabs = 8;
                position = "top";
                active = {
                  color = "rgba(224, 224, 224, 100%)";
                };
                inactive = {
                  color = "rgba(224, 224, 224, 30%)";
                };
                length.total-proportion = 1.0;
              };
            };

            overview.backdrop-color = "#0f0f0f";

            window-rules = [
              {
                geometry-corner-radius =
                  let
                    radius = 8.0;
                  in
                  {
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
                  { app-id = "io.github.kaii_lb.Overskride"; }
                  { app-id = "com.network.manager"; }
                  { app-id = "com.saivert.pwvucontrol"; }
                  { app-id = "org.pipewire.Helvum"; }
                  { app-id = "com.github.wwmm.easyeffects"; }
                  { app-id = "wdisplays"; }
                ];
                open-floating = true;
              }
              {
                matches = [
                  { is-window-cast-target = true; }
                ];

                focus-ring = {
                  active = {
                    color = "rgba(224, 53, 53, 100%)";
                  };
                  inactive = {
                    color = "rgba(224, 53, 53, 30%)";
                  };
                };

                tab-indicator = {
                  active = {
                    color = "rgba(224, 53, 53, 100%)";
                  };
                  inactive = {
                    color = "rgba(224, 53, 53, 30%)";
                  };
                };
              }
            ];
          };
        };
      };
    };
}
