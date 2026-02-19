{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.modules.displayManager.greetd.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config =
    let
      niriConfig = pkgs.writeText "niri-config" ''
        hotkey-overlay {
          skip-at-startup
        }
        environment {
          GTK_USE_PORTAL "0"
          GDK_DEBUG "no-portals"
        }
        input {
          keyboard {
            xkb {
              layout "eu"
            }
          } 
        }
        output "eDP-1" {
          scale 1.0
        }
        spawn-at-startup "sh" "-c" "${pkgs.regreet}/bin/regreet; pkill -f niri"
      '';
    in
    lib.mkIf (config.modules.displayManager.greetd.enable) {
      services.greetd.settings.default_session = {
        command = "niri -c ${niriConfig}";
        user = "greeter";
      };
      programs.regreet = {
        enable = true;
        theme.package = pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; };
        theme.name = "Graphite-Dark";
        iconTheme.package = pkgs.papirus-icon-theme;
        iconTheme.name = "Papirus-Dark";
        cursorTheme.package = pkgs.graphite-cursors;
        cursorTheme.name = "Graphite-Dark-Cursors";
        settings.background = {
          path = "${pkgs.graphite-gtk-theme.override { wallpapers = true; }}/share/backgrounds/wave-Dark.jpg";
          fit = "Fill";
        };
      };
    };
}
