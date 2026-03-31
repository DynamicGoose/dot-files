{
  lib,
  pkgs,
  username,
  userDescription,
  ...
}:
{
  # place password hash files in /home/${username}/secrets/ (including grub password)

  users.defaultUserShell = pkgs.nushell;

  # default user
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "cdrom"
      "dialout"
    ];
    hashedPasswordFile = "/home/${username}/secrets/${username}";
  };

  users.users.root.hashedPasswordFile = "/home/${username}/secrets/root";

  # set default passwords for vm builds
  virtualisation.vmVariant = {
    users.users = {
      root = {
        password = "root";
        hashedPasswordFile = lib.mkForce null;
      };
      ${username} = {
        password = username;
        hashedPasswordFile = lib.mkForce null;
      };
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
