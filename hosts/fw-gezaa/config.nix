{
  inputs,
  config,
  pkgs,
  ...
}: {
  modules.powerManagement.tlp.enable = true;
  services.fprintd.enable = true;
  networking.hostName = "fw-gezaa";

  home-manager.users.${config.modules.users.username} = { pkgs, ... }: {
    programs.niri.settings = {
      outputs."eDP-1".scale = 1.0;
    };
  };
}
