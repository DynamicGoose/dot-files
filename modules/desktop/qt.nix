{
  pkgs,
  username,
  ...
}:
{
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xkb";
  };

  home-manager.users.${username} =
    { config, pkgs, ... }:
    {
      xdg.configFile = {
        # kvantum theme
        "Kvantum/Graphite/GraphiteDark.kvconfig".source =
          "${pkgs.graphite-kde-theme-black}/share/Kvantum/Graphite/GraphiteDark.kvconfig";
        "Kvantum/Graphite/GraphiteDark.svg".source =
          "${pkgs.graphite-kde-theme-black}/share/Kvantum/Graphite/GraphiteDark.svg";
        "Kvantum/Graphite/Graphite.kvconfig".source =
          "${pkgs.graphite-kde-theme-black}/share/Kvantum/Graphite/Graphite.kvconfig";
        "Kvantum/Graphite/Graphite.svg".source =
          "${pkgs.graphite-kde-theme-black}/share/Kvantum/Graphite/Graphite.svg";
        "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=GraphiteDark";
      };

      qt = {
        enable = true;
        platformTheme = {
          name = "gtk3";
        };
        style.name = "kvantum";
      };
    };
}
