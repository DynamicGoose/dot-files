{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  options.modules.programs.waybar.desktop = lib.mkEnableOption "desktop config";

  config =
    let
      waybarSettings =
        if (config.modules.programs.waybar.desktop) then
          [
            {
              "spacing" = 4;
              "layer" = "top";
              "position" = "top";
              "margin-top" = 6;
              "margin-bottom" = 0;
              "margin-left" = 6;
              "margin-right" = 6;
              "height" = 34;
              "modules-left" = [
                "clock"
                "niri/workspaces"
              ];
              "modules-center" = [ "niri/window" ];
              "modules-right" = [
                "tray"
                "pulseaudio"
                "custom/menu"
              ];

              "niri/workspaces" = {
                "on-click" = "activate";
                "all-outputs" = false;
                "active-only" = false;
                "format" = "{icon}";
                "format-icons" = {
                  "default" = "";
                  "active" = "";
                };
              };

              "niri/window" = {
                "icon" = true;
              };

              "clock" = {
                "format" = "󱑇 {:%H:%M}";
                "tooltip" = false;
              };

              "pulseaudio" = {
                "format" = "{icon} {volume}%";
                "format-bluetooth" = "{icon}󰂯 {volume}%";
                "format-muted" = "";
                "format-icons" = {
                  "headphones" = "󰋋 ";
                  "phone" = " ";
                  "default" = [
                    ""
                    " "
                    " "
                  ];
                };
                "on-click" = "pwvucontrol";
                "menu" = "on-click-right";
                "menu-file" = "~/.config/waybar/audio_menu.xml";
                "menu-actions" = {
                  "toggle-input" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
                  "toggle-output" = "wpctl set-mute @DEFAULT_SINK@ toggle";
                  "settings" = "nohup pwvucontrol > /dev/null 2>&1 & disown && exit";
                  "patchbay" = "nohup helvum > /dev/null 2>&1 & disown && exit";
                  "effects" = "nohup easyeffects > /dev/null 2>&1 & disown && exit";
                };
              };

              "tray" = {
                "spacing" = 4;
                "reverse-direction" = true;
              };

              "custom/menu" = {
                "format" = "{icon}";
                "tooltip" = true;
                "format-icons" = {
                  "notification" = "<span foreground='#E03535'><sup></sup></span>";
                  "none" = "";
                  "dnd-notification" = "<span foreground='#E03535'><sup></sup></span>";
                  "dnd-none" = "";
                  "inhibited-notification" = "<span foreground='#E03535'><sup></sup></span>";
                  "inhibited-none" = "";
                  "dnd-inhibited-notification" = "<span foreground='#E03535'><sup></sup></span>";
                  "dnd-inhibited-none" = "";
                };
                "exec" = "swaync-client -swb";
                "return-type" = "json";
                "on-click" = "swaync-client -t -sw";
                "menu" = "on-click-right";
                "menu-file" = "~/.config/waybar/notify_menu.xml";
                "menu-actions" = {
                  "toggle-dnd" = "swaync-client -d -sw";
                  "clear-all" = "swaync-client -C -sw";
                };
              };
            }
          ]
        else
          [
            {
              "spacing" = 4;
              "layer" = "top";
              "position" = "top";
              "margin-top" = 6;
              "margin-bottom" = 0;
              "margin-left" = 6;
              "margin-right" = 6;
              "height" = 34;
              "modules-left" = [
                "clock"
                "niri/workspaces"
              ];
              "modules-center" = [ "niri/window" ];
              "modules-right" = [
                "tray"
                "pulseaudio"
                "backlight"
                "battery"
                "custom/menu"
              ];

              "niri/workspaces" = {
                "on-click" = "activate";
                "all-outputs" = false;
                "active-only" = false;
                "format" = "{icon}";
                "format-icons" = {
                  "default" = "";
                  "active" = "";
                };
              };

              "niri/window" = {
                "icon" = true;
              };

              "backlight" = {
                "format" = "{icon} {percent}%";
                "format-icons" = [
                  "󰃞"
                  "󰃟"
                  "󰃠"
                ];
              };

              "battery" = {
                "format" = "{icon} {capacity}%";
                "format-icons" = [
                  "󰁺"
                  "󰁻"
                  "󰁼"
                  "󰁽"
                  "󰁾"
                  "󰁿"
                  "󰂀"
                  "󰂁"
                  "󰂂"
                  "󰁹"
                ];
              };

              "clock" = {
                "format" = "󱑇 {:%H:%M}";
                "tooltip" = false;
              };

              "pulseaudio" = {
                "format" = "{icon} {volume}%";
                "format-bluetooth" = "{icon}󰂯 {volume}%";
                "format-muted" = "";
                "format-icons" = {
                  "headphones" = "󰋋 ";
                  "phone" = " ";
                  "default" = [
                    ""
                    " "
                    " "
                  ];
                };
                "on-click" = "pwvucontrol";
                "menu" = "on-click-right";
                "menu-file" = "~/.config/waybar/audio_menu.xml";
                "menu-actions" = {
                  "toggle-input" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
                  "toggle-output" = "wpctl set-mute @DEFAULT_SINK@ toggle";
                  "settings" = "nohup pwvucontrol > /dev/null 2>&1 & disown && exit";
                  "patchbay" = "nohup helvum > /dev/null 2>&1 & disown && exit";
                  "effects" = "nohup easyeffects > /dev/null 2>&1 & disown && exit";
                };
              };

              "tray" = {
                "spacing" = 4;
                "reverse-direction" = true;
              };

              "custom/menu" = {
                "format" = "{icon}";
                "tooltip" = true;
                "format-icons" = {
                  "notification" = "<span foreground='#E03535'><sup></sup></span>";
                  "none" = "";
                  "dnd-notification" = "<span foreground='#E03535'><sup></sup></span>";
                  "dnd-none" = "";
                  "inhibited-notification" = "<span foreground='#E03535'><sup></sup></span>";
                  "inhibited-none" = "";
                  "dnd-inhibited-notification" = "<span foreground='#E03535'><sup></sup></span>";
                  "dnd-inhibited-none" = "";
                };
                "exec" = "swaync-client -swb";
                "return-type" = "json";
                "on-click" = "swaync-client -t -sw";
                "menu" = "on-click-right";
                "menu-file" = "~/.config/waybar/notify_menu.xml";
                "menu-actions" = {
                  "toggle-dnd" = "swaync-client -d -sw";
                  "clear-all" = "swaync-client -C -sw";
                };
              };
            }
          ];
    in
    {
      environment.systemPackages = with pkgs; [
        easyeffects
        pwvucontrol
        helvum
        swaynotificationcenter
      ];

      home-manager.users.${username} =
        { config, lib, ... }:
        {
          xdg.configFile = {
            "waybar/audio_menu.xml".text = ''
              <?xml version="1.0" encoding="UTF-8"?>
              <interface>
                <object class="GtkMenu" id="menu">
                  <child>
                    <object class="GtkMenuItem" id="toggle-input">
                      <property name="label">Toggle Input</property>
                    </object>
                  </child>
                  <child>
                    <object class="GtkMenuItem" id="toggle-output">
                      <property name="label">Toggle Output</property>
                    </object>
                  </child>
                  <child>
                    <object class="GtkMenuItem" id="settings">
                      <property name="label">Settings</property>
                    </object>
                  </child>
                  <child>
                    <object class="GtkMenuItem" id="patchbay">
                      <property name="label">Patchbay</property>
                    </object>
                  </child>
                  <child>
                    <object class="GtkMenuItem" id="effects">
                      <property name="label">Effects</property>
                    </object>
                  </child>
                </object>
            '';
            "waybar/notify_menu.xml".text = ''
              <?xml version="1.0" encoding="UTF-8"?>
              <interface>
                <object class="GtkMenu" id="menu">
                  <child>
                    <object class="GtkMenuItem" id="toggle-dnd">
                      <property name="label">Toggle Do Not Disturb</property>
                    </object>
                  </child>
                  <child>
                    <object class="GtkMenuItem" id="clear-all">
                      <property name="label">Clear All Notifications</property>
                    </object>
                  </child>
                </object>
            '';
          };

          programs.waybar = {
            enable = true;

            settings = waybarSettings;

            style = ''
              * {
                font-size: 16px;
                font-family: "Ubuntu Nerdfont";
                font-weight: Bold;
                padding: 0 4px 0 4px;
              }
              window#waybar {
                background: rgba(15, 15, 15, 0.999);
                color: #E0E0E0;
                border: Solid;
                border-radius: 10px;
                border-width: 2px;
                border-color: #E0E0E0;
              }
              #workspaces button {
                background: #0F0F0F;
                color: #E0E0E0;
                margin: 4px 2px 4px 2px;
                padding: 0;
              }
              #workspaces button.active {
                background: #0F0F0F;
                color: #E0E0E0;
                margin: 4px 2px 4px 2px;
              }
              #tray {
                padding: 0;
              }
              menu {
                border: none;
                margin: 0;
                padding: 4px;
              }
              menuitem {
                padding: 6px;
                margin: 0;
              }
            '';
          };
        };
    };
}
