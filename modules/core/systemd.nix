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
      "user@".serviceConfig = {
        ProtectSystem = "strict";
        ProtectClock = true;
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectProc = "invisible";
        PrivateTmp = true;
        PrivateNetwork = true;
        MemoryDenyWriteExecute = false;
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_NETLINK"
          "AF_BLUETOOTH"
        ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallFilter = [
          "~@keyring"
          "~@swap"
          "~@debug"
          "~@module"
          "~@obsolete"
          "~@cpu-emulation"
        ];
        SystemCallArchitectures = "native";
      };
      acpid.serviceConfig = {
        ProtectSystem = "full";
        ProtectHome = true;
        RestrictAddressFamilies = [
          "AF_INET"
          "AF_INET6"
        ];
        SystemCallFilter = "~@clock @cpu-emulation @debug @module @mount @raw-io @reboot @swap";
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
      };

      auditd.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "full";
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectProc = "invisible";
        ProtectClock = true;
        PrivateTmp = true;
        PrivateNetwork = true;
        PrivateMounts = true;
        PrivateDevices = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = [
          "~AF_INET6"
          "~AF_INET"
          "~AF_PACKET"
        ];
        MemoryDenyWriteExecute = true;
        LockPersonality = true;
        SystemCallFilter = [
          "~@clock"
          "~@module"
          "~@mount"
          "~@swap"
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

      NetworkManager.serviceConfig = {
        NoNewPrivileges = true;
        ProtectHome = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectClock = true;
        ProtectHostname = true;
        ProtectProc = "invisible";
        PrivateTmp = true;
        RestrictRealtime = true;
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_NETLINK"
          "AF_INET"
          "AF_INET6"
          "AF_PACKET"
        ];
        RestrictNamespaces = true;
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        SystemCallFilter = [
          "~@mount"
          "~@module"
          "~@swap"
          "~@obsolete"
          "~@cpu-emulation"
          "ptrace"
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
      systemd-rfkill.serviceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        SystemCallArchitectures = "native";
        UMask = "0077";
        IPAddressDeny = "any";
      };
      systemd-machined.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectClock = true;
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectProc = "invisible";
        PrivateTmp = true;
        PrivateMounts = true;
        PrivateUsers = true;
        PrivateNetwork = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = [ "AF_UNIX" ];
        MemoryDenyWriteExecute = true;
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
