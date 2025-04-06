{ config, pkgs, lib, username, userDescription, ... }: {
  users.defaultUserShell = pkgs.zsh;
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = ["networkmanager" "wheel" "audio"];
  };

  # set default passwords for vm builds
  virtualisation.vmVariant = {
    users.users. = {
      root.initialPassword = "root";
      ${username}.initialPassword = username;
    };
  };
}
