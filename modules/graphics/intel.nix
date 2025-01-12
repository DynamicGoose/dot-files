{
  config,
  pkgs,
  ...
}: {
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-sdk
    intel-media-driver
    intel-vaapi-driver
    libvdpau-va-gl
  ];
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
}
