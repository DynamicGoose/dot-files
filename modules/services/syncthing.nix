{ config, pkgs, inputs, username, ... }: {
  home-manager.users.${username} = { config, ... }: {
    services.syncthing = {
      enable = true;
      extraOptions = ["--gui-apikey=gezaa"];
    };
  };
}
