{
  pkgs,
  username,
  ...
}:
{
  environment.shells = with pkgs; [
    nushell-wrapped
    bash
  ];

  environment.systemPackages = [ pkgs.starship-wrapped ];
  environment.sessionVariables.STARSHIP_CONFIG = "${pkgs.starship-wrapped}/starship.toml";

  # copy nushell config, for some reason doesn't work with just the wrapped package
  systemd.services.nushellConfig =
    let
      nushell-config = "${pkgs.nushell-wrapped}/nu-config/config.nu";
      copy-config = pkgs.writeShellScript "copy-kvantum-config.sh" ''
        [ -d /home/${username}/.config/nushell ] || ${pkgs.coreutils}/bin/mkdir /home/${username}/.config/nushell
        ${pkgs.coreutils}/bin/ln -sf ${nushell-config} /home/${username}/.config/nushell/config.nu
      '';
    in
    {
      description = "Copy nushell user config";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = copy-config;
      };
    };

  programs.bash.interactiveShellInit = "eval \"$(starship init bash)\"";
}
