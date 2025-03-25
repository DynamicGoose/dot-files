{ config, pkgs, inputs, username, ... }: {
  environment.systemPackages = [pkgs.hyprlock];

  home-manager.users.${username} = { config, ... }: {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          grace = 0;
          no_fade_in = false;
          ignore_empty_input = true;
        };

        auth = {
          fingerprint = {
            enabled = true;
          };
        };

        background = [
          {
            path = "screenshot";
            color = "rgba(0, 0, 0, 0.0)";
            blur_passes = 2;
            blur_size = 4;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -20";
            outline_thickness = 2;
            dots_size = 0.2;
            dots_spacing = 0.3;
            dots_center = true;
            dots_rounding = -1;
            outer_color = "rgb(240, 240, 240)";
            inner_color = "rgb(24, 24, 24)";
            font_color = "rgb(255, 255, 255)";
            fade_on_empty = true;
            fade_timeout = 1000;
            placeholder_text = "<i>Password</i>";
            hide_input = false;
            rounding = 10;
            check_color = "rgb(50, 180, 50)";
            fail_color = "rgb(180, 50, 50)";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            fail_transition = 300;
            capslock_color = -1;
            numlock_color = -1;
            bothlock_color = -1;
            invert_numlock = false;
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            text = "$TIME";
            color = "rgba(240, 240, 240, 1.0)";
            font_size = 48;
            font_family = "Ubuntu Nerd Font Med";
            position = "0, 64";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
