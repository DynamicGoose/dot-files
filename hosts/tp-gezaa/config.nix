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
}
