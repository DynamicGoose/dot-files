{ config, pkgs, ... }: {
  users.defaultUserShell = pkgs.zsh;
  users.users = {
    gezaa = {
      isNormalUser = true;
      description = "Géza Ahsendorf";
      extraGroups = ["networkmanager" "wheel" "audio"];
    };
  };
}
