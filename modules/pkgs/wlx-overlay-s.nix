{ username, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wlx-overlay-s
    pkgs.wayvr-dashboard
  ];

  home-manager.users.${username} =
    { config, ... }:
    {
      xdg.configFile."wlxoverlay/wayvr.conf.d/dashboard.yaml".text = ''
        dashboard:
          exec: "wayvr-dashboard"
          args: ""
          env: []
      '';
    };
}
