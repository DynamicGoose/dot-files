{
  username,
  ...
}:
{
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "/home/${username}";
    configDir = "/home/${username}/.local/state/syncthing";
    extraFlags = [ "--gui-apikey=gezaa" ];
  };
}
