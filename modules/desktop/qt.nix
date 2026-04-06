{
  username,
  pkgs,
  ...
}:
{
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xkb";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  qt = {
    enable = true;
    style = "kvantum";
  };

  # Copy Kvantum config
  systemd.services.kvantumConfig =
    let
      kvantum-config = pkgs.writeText "kvantum.kvconfig" "[General]\ntheme=GraphiteDark";
      copy-config = pkgs.writeShellScript "copy-kvantum-config.sh" ''
        ${pkgs.coreutils}/bin/rm -rf /home/${username}/.config/Kvantum
        ${pkgs.coreutils}/bin/mkdir /home/${username}/.config/Kvantum
        ${pkgs.coreutils}/bin/ln -sf ${kvantum-config} /home/${username}/.config/Kvantum/kvantum.kvconfig
        ${pkgs.coreutils}/bin/ln -sf ${pkgs.graphite-kde-theme-black}/share/Kvantum/Graphite /home/${username}/.config/Kvantum/Graphite
      '';
    in
    {
      description = "Copy Kvantum user config";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = copy-config;
      };
    };
}
