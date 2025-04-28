{ ... }:
{
  programs.droidcam.enable = true;
  programs.adb.enable = true;

  # OBS cam
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
}
