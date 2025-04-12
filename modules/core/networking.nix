{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
