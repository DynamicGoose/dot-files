{
  # when using auto-generated hardware-configuration.nix, this will also enable microcode updates
  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = true;
}
