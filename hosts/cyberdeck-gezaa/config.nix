{
  lib,
  pkgs,
  username,
  ...
}:
{
  modules = {
    powerManagement.tlp.enable = true;
    virtualisation.waydroid.enable = true;
  };

  environment.systemPackages = [ pkgs.squeekboard ];

  systemd.user.services.squeekboard = {
    description = "On-Screen Keyboard";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.squeekboard}/bin/.squeekboard-wrapped";
      Restart = "on-failure";
    };
  };

  home-manager.users.${username} = {
    programs.niri.settings = {
      layout = {
        default-column-width.proportion = lib.mkOverride 1.0;
      };

      window-rules = lib.mkOverride [
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

          switch-events = {
            tablet-mode-on.action.spawn = [
              "sh"
              "-c"
              "systemctl --user start squeekboard.service"
            ];
            tablet-mode-off.action.spawn = [
              "sh"
              "-c"
              "systemctl --user stop squeekboard.service"
            ];
          };
        }
      ];
    };
  };
}
