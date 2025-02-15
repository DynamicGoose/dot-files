{
  inputs,
  config,
  pkgs,
  ...
}: {
  modules = {
    graphics.type = "intel";
    powerManagement.tlp.enable = true;
  };
  
  networking.hostName = "tp-gezaa";

  home-manager.users.${config.modules.users.username} = { pkgs, ... }: {
    programs.niri.settings = {
      outputs."eDP-1".scale = 1.0;
    };
  };
}
