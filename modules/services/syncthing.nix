{ config, pkgs, inputs, ... }: {
  home-manager.users.gezaa = { config, ... }: {
    services.syncthing = {
      enable = true;
      extraOptions = ["--gui-apikey=gezaa"];
    };
  };
}
