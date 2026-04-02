{ username, ... }:
{
  services.xserver.desktopManager.phosh = {
    enable = true;
    user = username;
    group = "users";
  };
}
