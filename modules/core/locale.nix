{
  time.timeZone = "Europe/Berlin";
  location.provider = "geoclue2";

  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_CA.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "en_CA.UTF-8";
  };

  # Console keymap
  console.keyMap = "de";

  # x11 Keymap
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
}
