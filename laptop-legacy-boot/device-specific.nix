{
  inputs,
  config,
  pkgs,
  ...
}: {
  # Bootloader
  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
    };
  };

  # Host name
  networking.hostName = "dell-d830";

  # Graphics drivers
  hardware.graphics. extraPackages = with pkgs; [
    intel-media-sdk
    intel-media-driver
    intel-vaapi-driver
    libvdpau-va-gl
  ];
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
}
