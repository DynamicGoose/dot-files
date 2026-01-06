{ username, ... }:
{
  home-manager.users.${username} =
    { pkgs, ... }:
    {
      xdg.configFile."wlxoverlay/wayvr.conf.d/dashboard.yaml".text = ''
        dashboard:
          exec: "${pkgs.wayvr-dashboard}/bin/wayvr-dashboard"
          args: ""
          env: []
      '';
    };
}
