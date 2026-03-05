{ lib, ... }:
{
  security = {
    # Kernel
    protectKernelImage = true;
    allowUserNamespaces = true;

    # run0
    run0.enableSudoAlias = true;
    sudo.enable = false;

    rtkit.enable = true;
    polkit.enable = true;

    wrappers = {
      su.enable = lib.mkForce false;
      sudoedit.enable = lib.mkForce false;
      sg.enable = lib.mkForce false;
      pkexec.setuid = lib.mkForce false;
      newgrp.setuid = lib.mkForce false;
    };

    pam.loginLimits = [
      {
        domain = "*";
        item = "rtprio";
        type = "-";
        value = 99;
      }
      {
        domain = "*";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "*";
        item = "nofile";
        type = "-";
        value = "99999";
      }
      # "disable" kernel coredumps (set their maximum size to 0)
      {
        domain = "*";
        item = "core";
        type = "-";
        value = "0";
      }
    ];

    # apparmor
    apparmor.enable = true;
  };
}
