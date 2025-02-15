{ config, pkgs, inputs, ... }: {
  home-manager.users.${config.modules.users.username} = { config, ... }: {
    services.syncthing = {
      enable = true;
      extraOptions = ["--gui-apikey=gezaa"];
    };
  };
}
