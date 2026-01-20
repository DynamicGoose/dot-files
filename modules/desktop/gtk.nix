{
  pkgs,
  username,
  ...
}:
{
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };
    }
  ];
  home-manager.users.${username} =
    { config, ... }:
    {
      gtk = {
        enable = true;
        iconTheme.name = "Papirus-Dark";
        iconTheme.package = pkgs.papirus-icon-theme;
        theme.name = "Graphite-Dark";
        theme.package = pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; };
      };
    };
}
