{
  pkgs,
  lib,
  inputs,
  system,
  settingsOverrides ? { },
}:
let
  mergeAttrsRecursive =
    with lib;
    attrList:
    let
      f =
        attrPath:
        zipAttrsWith (
          n: values:
          if tail values == [ ] then
            head values
          else if all isList values then
            unique (concatLists values)
          else if all isAttrs values then
            f (attrPath ++ [ n ]) values
          else
            last values
        );
    in
    f [ ] attrList;
in
inputs.wrapper-modules.wrappers.niri.wrap {
  inherit pkgs;
  settings = mergeAttrsRecursive [
    {
      prefer-no-csd = _: { };
      hotkey-overlay.skip-at-startup = _: { };
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
          "${pkgs.wl-clip-persist}"
          "--clipboard"
          "regular"
        ]
        [
          "${pkgs.cliphist}"
          "wipe"
        ]
        # Can only be started if it exists
        [
          "systemctl"
          "--user"
          "start"
          "hypridle.service"
        ]
        [ "${lib.getExe inputs.goose-shell.packages.${system}.default}" ]
      ];

      spawn-sh-at-startup = [
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
        "sleep 4 && ${
          lib.getExe inputs.goose-shell.packages.${system}.default
        } ipc call networking setBluetoothEnabled false && ${
          lib.getExe inputs.goose-shell.packages.${system}.default
        } ipc call networking setBluetoothEnabled false"
        "id=0"
      ];

      input = {
        disable-power-key-handling = _: { };
        warp-mouse-to-focus = _: { };
        focus-follows-mouse = _: { props.max-scroll-amount = "25%"; };
        mouse.accel-speed = 0.5;
        touchpad = {
          tap = _: { };
          natural-scroll = _: { };
          accel-speed = 0.5;
        };
        keyboard = {
          numlock = _: { };
          xkb.layout = "de";
        };
      };

      binds = {
        "Alt+Return".toggle-overview = _: { };
        "Alt+H".focus-column-or-monitor-left = _: { };
        "Alt+J".focus-window-or-workspace-down = _: { };
        "Alt+K".focus-window-or-workspace-up = _: { };
        "Alt+L".focus-column-or-monitor-right = _: { };

        "Ctrl+Alt+D".toggle-window-floating = _: { };
        "Ctrl+Alt+F".fullscreen-window = _: { };
        "Ctrl+Alt+L".consume-or-expel-window-right = _: { };
        "Ctrl+Alt+H".consume-or-expel-window-left = _: { };
        "Ctrl+Alt+K".move-window-up-or-to-workspace-up = _: { };
        "Ctrl+Alt+J".move-window-down-or-to-workspace-down = _: { };
        "Ctrl+Alt+Return".move-window-to-monitor-next = _: { };
        "Ctrl+Alt+Q".switch-preset-column-width = _: { };
        "Ctrl+Alt+A".switch-preset-window-height = _: { };
        "Ctrl+Alt+W".maximize-column = _: { };
        "Ctrl+Alt+S".expand-column-to-available-width = _: { };
        "Ctrl+Alt+Tab".toggle-column-tabbed-display = _: { };

        "Alt+1".focus-workspace = 1;
        "Alt+2".focus-workspace = 2;
        "Alt+3".focus-workspace = 3;
        "Alt+4".focus-workspace = 4;
        "Alt+5".focus-workspace = 5;
        "Alt+6".focus-workspace = 6;
        "Alt+7".focus-workspace = 7;
        "Alt+8".focus-workspace = 8;
        "Alt+9".focus-workspace = 9;
        "Alt+0".focus-workspace = 10;

        "Print".screenshot = _: { };
        "XF86PowerOff".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "panelService"
          "togglePowerMenu"
        ];
        "XF86AudioMute".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
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
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "volume"
          "increase"
          "5"
        ];
        "XF86AudioLowerVolume".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "volume"
          "decrease"
          "5"
        ];
        "XF86MonBrightnessUp".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "brightness"
          "increase"
          "5"
        ];
        "XF86MonBrightnessDown".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "brightness"
          "decrease"
          "5"
        ];
        "Super+X".close-window = _: { };
        "Super+A".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "panelService"
          "toggleLauncher"
        ]; # launcher
        "Super+L".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "session"
          "lock"
        ]; # lock screen
        "Super+P".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "panelService"
          "togglePowerMenu"
        ]; # power options
        "Super+S".spawn = [
          "${lib.getExe inputs.goose-shell.packages.${system}.default}"
          "ipc"
          "call"
          "panelService"
          "toggleControlCenter"
        ]; # notification hub
        "Super+T".spawn = "kitty"; # terminal
        "Super+C".spawn-sh = [ "pidof hyprpicker || hyprpicker -la" ]; # color-picker
        "Super+K".spawn-sh = [ "keepassxc ~/secrets/main.kdbx" ];
      };

      gestures.hot-corners.off = _: { };

      layout = {
        gaps = 8;
        default-column-width.proportion = 0.5;
        insert-hint.color = "rgba(224, 224, 224, 30%)";
        border.off = _: { };

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

        focus-ring = {
          width = 2;
          active-color = "#e0e0e0ff";
          inactive-color = "#00000000";
        };

        tab-indicator = {
          place-within-column = _: { };
          width = 8;
          corner-radius = 8;
          gap = 8;
          gaps-between-tabs = 8;
          position = "top";
          active-color = "rgba(224, 224, 224, 100%)";
          inactive-color = "rgba(224, 224, 224, 30%)";
          length = _: { props.total-proportion = 1.0; };
        };
      };

      overview.backdrop-color = "#0f0f0f";

      recent-windows.highlight = {
        active-color = "rgba(224, 224, 224, 100%)";
        urgent-color = "rgba(224, 53, 53, 100%)";
        corner-radius = 8;
      };

      window-rules = [
        {
          geometry-corner-radius = 8;
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
        {
          matches = [
            { app-id = "io.github.kaii_lb.Overskride"; }
            { app-id = "com.network.manager"; }
            { app-id = "com.saivert.pwvucontrol"; }
            { app-id = "io.github.dp0sk.Crosspipe"; }
            { app-id = "com.github.wwmm.easyeffects"; }
            { app-id = "wdisplays"; }
          ];

          open-floating = true;
        }
        {
          matches = [ { is-window-cast-target = true; } ];

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

      animations = {
        workspace-switch.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0003;
          };
        };

        horizontal-view-movement.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0003;
          };
        };

        window-movement.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0003;
          };
        };

        window-resize.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0003;
          };
        };

        config-notification-open-close.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0003;
          };
        };

        exit-confirmation-open-close.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0003;
          };
        };

        overview-open-close.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0003;
          };
        };

        recent-windows-close.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0003;
          };
        };

        window-open = {
          duration-ms = 128;
          curve = [
            "cubic-bezier"
            0.5
            0
            0.5
            1.0
          ];
        };

        window-close = {
          duration-ms = 128;
          curve = [
            "cubic-bezier"
            0.5
            0
            0.5
            1.0
          ];
        };

        screenshot-ui-open = {
          duration-ms = 256;
          curve = [
            "cubic-bezier"
            0.5
            0
            0.5
            1.0
          ];
        };
      };
    }
    settingsOverrides
  ];
}
