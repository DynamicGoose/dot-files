{ pkgs, ... }:
{
  # global config
  environment.etc =
    let
      settings = ''
        [Settings]
        gtk-cursor-theme-name=graphite-dark
        gtk-cursor-theme-size=24
        gtk-icon-theme-name=Papirus-Dark
        gtk-theme-name=Graphite-Dark
      '';
    in
    {
      "xdg/gtk-2.0/gtkrc".text = ''
        gtk-cursor-theme-name = "graphite-dark"
        gtk-cursor-theme-size = 24
        gtk-icon-theme-name = "Papirus-Dark"
        gtk-theme-name = "Graphite-Dark"
      '';
      "xdg/gtk-3.0/settings.ini".text = settings;
      "xdg/gtk-4.0/settings.ini".text = settings;
      "xdg/gtk-4.0/gtk.css".text = ''
        /**
         * GTK 4 reads the theme configured by gtk-theme-name, but ignores it.
         * It does however respect user CSS, so import the theme from here.
        **/
        @import url("file://${
          pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; }
        }/share/themes/Graphite-Dark/gtk-4.0/gtk.css");
      '';
    };

  environment.systemPackages = [
    (pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; })
    pkgs.papirus-icon-theme
    pkgs.graphite-cursors
  ];

  environment.sessionVariables.GTK_THEME = "Graphite-Dark"; # for some reason gtk4 doesn't respect other settings

  # dconf settings
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          cursor-theme = "graphite-dark";
          gtk-theme = "Graphite-Dark";
          icon-theme = "Papirus-Dark";
          cursor-size = "24";
        };
      };
    }
  ];
}
