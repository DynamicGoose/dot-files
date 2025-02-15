{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  modules.powerManagement.tlp.enable = true;
  networking.hostName = "hp-gezaa";
}
