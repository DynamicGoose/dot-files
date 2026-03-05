{
  lib,
  pkgs,
  username,
  userDescription,
  ...
}:
{
  # place password hash files in /home/${username}/secrets/ (including grub password)

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

  environment.etc."/security/pwquality.conf".text = ''
    minlen=8
  '';

  # .cache tmpfs
  fileSystems."home/${username}/.cache" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "size=4G"
      "mode=777"
    ];
  };
}
