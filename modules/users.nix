{ config, pkgs, lib, username, userDescription, ... }: {
  users.defaultUserShell = pkgs.zsh;
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = ["networkmanager" "wheel" "audio"];
  };
}
