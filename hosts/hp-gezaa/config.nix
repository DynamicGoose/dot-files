{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  modules.powerManagement.tlp.enable = true;
}
