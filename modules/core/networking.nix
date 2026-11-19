{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    wifi.scanRandMacAddress = true;
    wifi.macAddress = "random";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
