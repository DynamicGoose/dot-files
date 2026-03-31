{ username, ... }: {
  services.xserver.desktopManager.phosh = {
    user = username;
    group = "users";
  };
}
