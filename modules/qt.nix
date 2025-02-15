{ config, pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };
  
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xkb";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  environment.systemPackages = [
    pkgs.libsForQt5.qt5ct
    pkgs.libsForQt5.qtstyleplugin-kvantum
  ];

  home-manager.users.${config.modules.users.username} = { config, pkgs, ... }: {
    xdg.configFile = {
      # kvantum theme
      "Kvantum/Graphite/GraphiteDark.kvconfig".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite/GraphiteDark.kvconfig";
      "Kvantum/Graphite/GraphiteDark.svg".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite/GraphiteDark.svg";
      "Kvantum/Graphite/Graphite.kvconfig".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite/Graphite.kvconfig";
      "Kvantum/Graphite/Graphite.svg".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite/Graphite.svg";
      "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=GraphiteDark";
    };
  };
}
