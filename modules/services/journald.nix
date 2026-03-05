{
  services.journald = {
    extraConfig = "SystemMaxUse=250M";
    upload.enable = false;
  };
}
