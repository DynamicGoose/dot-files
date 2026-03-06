{ lib, ... }:
{
  systemd = {
    user.extraConfig = "DefaultLimitNOFILE=524288";
    settings.Manager = {
      DefaultLimitNOFILE = 524288;
    };
    coredump.enable = false; # disable coredumps for security reasons

    # imporve service security
    services = {
      cups.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "full";
        ProtectHome = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectHostname = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        RestrictRealtime = true;
        RestrictNamespaces = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_NETLINK"
          "AF_INET"
          "AF_INET6"
          "AF_PACKET"
        ];

        MemoryDenyWriteExecute = true;
        SystemCallFilter = [
          "~@clock"
          "~@reboot"
          "~@debug"
          "~@module"
          "~@swap"
          "~@obsolete"
          "~@cpu-emulation"
        ];
        SystemCallArchitectures = "native";
        LockPersonality = true;
      };

      dbus.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "stric";
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        PrivateMounts = true;
        PrivateDevices = true;
        PrivateTmp = true;
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
        RestrictAddressFamilies = [
          "AF_UNIX"
        ];
        RestrictNamespaces = true;
        SystemCallErrorNumber = "EPERM";
        SystemCallArchitectures = "native";
        SystemCallFilter = [
          "~@obsolete"
          "~@resources"
          "~@debug"
          "~@mount"
          "~@reboot"
          "~@swap"
          "~@cpu-emulation"
        ];
        LockPersonality = true;
        IPAddressDeny = [
          "0.0.0.0/0"
          "::/0"
        ];
        MemoryDenyWriteExecute = true;
        DevicePolicy = "closed";
        UMask = 0077;
      };

      nscd.serviceConfig = {
        ProtectClock = true;
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectProc = "invisible";
        RestrictNamespaces = true;
        RestrictRealtime = true;
        MemoryDenyWriteExecute = true;
        LockPersonality = true;
        SystemCallFilter = [
          "~@mount"
          "~@swap"
          "~@clock"
          "~@obsolete"
          "~@cpu-emulation"
        ];
        SystemCallArchitectures = "native";
        CapabilityBoundingSet = [
          "~CAP_CHOWN"
          "~CAP_FSETID"
          "~CAP_SETFCAP"
        ];
      };

      bluetooth.serviceConfig = {
        ProtectKernelTunables = lib.mkDefault true;
        ProtectKernelModules = lib.mkDefault true;
        ProtectKernelLogs = lib.mkDefault true;
        ProtectHostname = true;
        ProtectControlGroups = true;
        ProtectProc = "invisible";
        SystemCallFilter = [
          "~@obsolete"
          "~@cpu-emulation"
          "~@swap"
          "~@reboot"
          "~@mount"
        ];
        SystemCallArchitectures = "native";
      };

      systemd-udevd.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        RestrictNamespaces = true;
        CapabilityBoundingSet = "~CAP_SYS_PTRACE ~CAP_SYS_PACCT";
      };

      nix-daemon.serviceConfig = {
        NoNewPrivileges = true;
        ProtectControlGroups = true;
        ProtectKernelModules = true;
        PrivateMounts = true;
        PrivateTmp = true;
        PrivateDevices = true;
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
        RestrictNamespaces = [ "~cgroup" ];
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_NETLINK"
          "AF_INET6"
          "AF_INET"
        ];
        CapabilityBoundingSet = [
          "~CAP_SYS_CHROOT"
          "~CAP_BPF"
          "~CAP_AUDIT_WRITE"
          "~CAP_AUDIT_CONTROL"
          "~CAP_AUDIT_READ"
          "~CAP_SYS_PTRACE"
          "~CAP_SYS_NICE"
          "~CAP_SYS_RESOURCE"
          "~CAP_SYS_RAWIO"
          "~CAP_SYS_TIME"
          "~CAP_SYS_PACCT"
          "~CAP_LINUX_IMMUTABLE"
          "~CAP_IPC_LOCK"
          "~CAP_WAKE_ALARM"
          "~CAP_SYS_TTY_CONFIG"
          "~CAP_SYS_BOOT"
          "~CAP_LEASE"
          "~CAP_BLOCK_SUSPEND"
          "~CAP_MAC_ADMIN"
          "~CAP_MAC_OVERRIDE"
        ];
        SystemCallErrorNumber = "EPERM";
        SystemCallArchitectures = "native";
        SystemCallFilter = [
          "~@resources"
          "~@module"
          "~@obsolete"
          "~@debug"
          "~@reboot"
          "~@swap"
          "~@cpu-emulation"
          "~@clock"
          "~@raw-io"
        ];
        LockPersonality = true;
        MemoryDenyWriteExecute = false;
        DevicePolicy = "closed";
        UMask = 0077;
      };
      systemd-journald.serviceConfig = {
        NoNewPrivileges = true;
        ProtectProc = "invisible";
        ProtectHostname = true;
        PrivateMounts = true;
      };
    };
  };
}
