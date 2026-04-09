{
  pkgs,
  ...
}:
{
  services = {
    gnome.gnome-keyring.enable = true;
    logind.settings.Login.HandlePowerKey = "ignore";
  };

  systemd = {
    user.services = {
      # Polkit
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    cliphist
    hyprpicker
    wl-clipboard # dependency of hyprpicker
    kitty
    playerctl
    wl-clip-persist
    goose-shell
  ];

  programs = {
    niri = {
      enable = true;
      useNautilus = false;
      package = pkgs.niri-wrapped;
    };

    dconf.enable = true;
    ssh.askPassword = "";
    xwayland.enable = true;
  };
}
