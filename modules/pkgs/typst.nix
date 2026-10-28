{
  pkgs,
  lib,
  config,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    tinymist
    typst
    typstyle
  ];

  # symlink templates dir
  systemd.services.typstTemplates =
    let
      link-templates = pkgs.writeShellScript "link-typst-templates" ''
        ${pkgs.coreutils}/bin/mkdir -p /home/${username}/Templates/typst
        ${pkgs.coreutils}/bin/mkdir -p /home/${username}/.local/share/typst/packages
        ${pkgs.coreutils}/bin/ln -sf /home/${username}/Templates/typst /home/${username}/.local/share/typst/packages/local
      '';
    in
    {
      description = "Link typst templates from user's Templates directory";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = link-templates;
      };
    };
}
