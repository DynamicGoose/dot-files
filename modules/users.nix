{
  pkgs,
  username,
  userDescription,
  ...
}:
{
  users.defaultUserShell = pkgs.nushell;
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
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
