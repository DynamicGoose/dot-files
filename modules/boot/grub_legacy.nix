{
  config,
  ...
}: {
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    splashImage = null;
  };
}
