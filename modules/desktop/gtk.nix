{
  pkgs,
  username,
  ...
}:
{
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
