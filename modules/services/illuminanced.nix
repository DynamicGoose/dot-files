{
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  options.modules.services.illuminanced.enable = lib.mkEnableOption "Enable illuminanced ALS service";

  config = lib.mkIf (config.modules.services.illuminanced.enable == true) {
    systemd.services.illuminanced = {
      description = "Ambient light monitoring Service";
      wants = [ "syslog.socket" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.illuminanced}/bin/illuminanced -c /home/${username}/.config/illuminanced.toml";
        Restart = "on-failure";
        PIDFile = "/run/illuminanced.pid";
      };
    };
  };
}
