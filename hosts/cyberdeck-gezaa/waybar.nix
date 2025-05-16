{
  lib,
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = [ pkgs.wlr-randr ];

  home-manager.users.${username} = {
    programs.waybar.settings = {
      "height" = lib.mkOverride 48;
      "modules-right" = lib.mkOverride [
        "tray"
        "pulseaudio"
        "backlight"
        "battery"
        "custom/rotate-screen"
        "custom/menu"
      ];
      "custom/rotate-screen" = {
        "format" = "󰑵";
        "tooltip" = "Rotate Screen";
        "menu" = "on-click";
        "menu-file" = "~/.config/waybar/rotate_menu.xml";
        "menu-actions" = {
          "horizontal" = "wlr-randr --output eDP-1 --transform normal";
          "vertical" = "wlr-rand --output eDP-1 --transform 90";
        };
      };
    };

    xdg.configFile."waybar/rotate_menu.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <interface>
        <object class="GtkMenu" id="menu">
          <child>
            <object class="GtkMenuItem" id="horizontal">
              <property name="label">Landscape</property>
            </object>
          </child>
          <child>
            <object class="GtkMenuItem" id="vertical">
              <property name="label">Portrait</property>
            </object>
          </child>
        </object>
    '';
  };
}
