{
  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = true;
    wifi.macAddress = "random";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
