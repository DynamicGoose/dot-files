{
  lib,
  pkgs,
  username,
  userDescription,
  ...
}:
{
  # place password hash files in /home/${username}/secrets/

  # admin user for system management
  users.defaultUserShell = pkgs.nushell;
  users.mutableUsers = false;
  users.users.admin = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = [ "wheel" ];
    hashedPasswordFile = "/home/${username}/secrets/admin";
    # openssh.authorizedKeys.keys = [];
  };

  # default user (doesn't have wheel)
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = lib.mkForce [
      "networkmanager"
      "audio"
      "video"
      "cdrom"
    ];
    hashedPasswordFile = "/home/${username}/secrets/${username}";
  };

  users.users.root.hashedPasswordFile = "/home/${username}/secrets/root";

  # set default passwords for vm builds
  virtualisation.vmVariant = {
    users.users = {
      root.password = "root";
      admin.password = "admin";
      ${username}.password = username;
    };
  };
}
