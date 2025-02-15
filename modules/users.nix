{ config, pkgs, lib, ... }: {
  options.modules.users = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "gezaa";
    };
    fullName = lib.mkOption {
      type = lib.types.str;
      default = "Géza Ahsendorf";
    };
  };
  
  config = {
    users.defaultUserShell = pkgs.zsh;
    users.users.${config.modules.users.username} = {
      isNormalUser = true;
      description = "${config.modules.users.fullName}";
      extraGroups = ["networkmanager" "wheel" "audio"];
    };
  };
}
