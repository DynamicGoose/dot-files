{
  pkgs,
  username,
  userDescription,
  ...
}:
{
  users.defaultUserShell = pkgs.zsh;
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "adbusers"
    ];
  };

  # set default passwords for vm builds
  virtualisation.vmVariant = {
    users.users = {
      root.password = "root";
      ${username}.password = username;
    };
  };
}
