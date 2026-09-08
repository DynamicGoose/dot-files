{
  services.journald = {
    settings.Journal.SystemMaxUse = "250M";
    upload.enable = false;
  };
}
