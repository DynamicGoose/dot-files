{
  inputs,
  config,
  pkgs,
  ...
}: {
  modules = {
    boot.deviceType = "removable";
    graphics.enable = false;
  };

  networking.hostName = "usb-gezaa";
}
