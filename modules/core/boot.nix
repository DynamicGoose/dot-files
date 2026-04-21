{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.modules.boot.deviceType = lib.mkOption {
    type = lib.types.str;
    default = "uefi";
  };

  config =
    let
      bootloader =
        if (config.modules.boot.deviceType == "legacy") then
          {
            limine = {
              enable = true;
              biosSupport = true;
              biosDevice = "/dev/sda";
              style.wallpapers = lib.mkForce [ ];
              style.graphicalTerminal.palette = "000000; F44336; 66BB6A; FB8C00; 42A5F5; F06292; 4DB6AC; 9E9E9E";
            };
          }
        else if (config.modules.boot.deviceType == "removable") then
          {
            efi = {
              canTouchEfiVariables = false;
              efiSysMountPoint = "/boot";
            };
            limine = {
              enable = true;
              biosSupport = true;
              efiSupport = true;
              efiInstallAsRemovable = true;
              additionalFiles."efi/netbootxyz/netbootxyz.efi" = "${pkgs.netbootxyz-efi}";
              extraEntries = ''
                /Netboot.xyz
                  protocol: efi
                  image_path: boot():/limine/efi/netbootxyz/netbootxyz.efi
              '';
              style.wallpapers = lib.mkForce [ ];
              style.graphicalTerminal.palette = "000000; F44336; 66BB6A; FB8C00; 42A5F5; F06292; 4DB6AC; 9E9E9E";
            };
          }
        else
          {
            efi = {
              canTouchEfiVariables = true;
              efiSysMountPoint = "/boot";
            };
            limine = {
              enable = true;
              efiSupport = true;
              enrollConfig = true;
              panicOnChecksumMismatch = true;
              secureBoot = {
                enable = true;
                autoGenerateKeys = true;
                autoEnrollKeys.enable = true;
              };
              style.wallpapers = lib.mkForce [ ];
              style.graphicalTerminal.palette = "000000; F44336; 66BB6A; FB8C00; 42A5F5; F06292; 4DB6AC; 9E9E9E";
            };
          };
    in
    {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems = [ "ntfs" ];
        plymouth = {
          enable = true;
          theme = "bgrt";
        };

        # Silent boot for plymouth
        consoleLogLevel = 0;
        initrd.verbose = false;

        binfmt.emulatedSystems = [ "aarch64-linux" ];

        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "loglevel=3"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "udev.log_priority=3"
          "vsyscall=none"
          "debugfs=off"
        ];

        # hardening
        kernel.sysctl = {
          "fs.suid_dumpable" = 0;
          # prevent pointer leaks
          "kernel.kptr_restrict" = 2;
          # restrict kernel log to CAP_SYSLOG capability
          "kernel.dmesg_restrict" = 1;
          # restrict loading TTY line disciplines to the CAP_SYS_MODULE
          "dev.tty.ldisk_autoload" = 0;
          # prevent exploit of use-after-free flaws
          "vm.unprivileged_userfaultfd" = 0;
          # kexec is used to boot another kernel during runtime and can be abused
          "kernel.kexec_load_disabled" = 1;
          # Kernel self-protection
          # SysRq exposes a lot of potentially dangerous debugging functionality to unprivileged users
          # 4 makes it so a user can only use the secure attention key. A value of 0 would disable completely
          "kernel.sysrq" = 4;

          # Network
          # protect against SYN flood attacks (denial of service attack)
          "net.ipv4.tcp_syncookies" = 1;
          # protection against TIME-WAIT assassination
          "net.ipv4.tcp_rfc1337" = 1;
          # enable source validation of packets received (prevents IP spoofing)
          "net.ipv4.conf.default.rp_filter" = 1;
          "net.ipv4.conf.all.rp_filter" = 1;

          "net.ipv4.conf.all.accept_redirects" = 0;
          "net.ipv4.conf.default.accept_redirects" = 0;
          "net.ipv4.conf.all.secure_redirects" = 0;
          "net.ipv4.conf.default.secure_redirects" = 0;
          # Protect against IP spoofing
          "net.ipv6.conf.all.accept_redirects" = 0;
          "net.ipv6.conf.default.accept_redirects" = 0;
          "net.ipv4.conf.all.send_redirects" = 0;
          "net.ipv4.conf.default.send_redirects" = 0;

          # prevent man-in-the-middle attacks
          "net.ipv4.icmp_echo_ignore_all" = 1;

          # ignore ICMP request, helps avoid Smurf attacks
          "net.ipv4.conf.all.forwarding" = 0;
          "net.ipv4.conf.default.accept_source_route" = 0;
          "net.ipv4.conf.all.accept_source_route" = 0;
          "net.ipv6.conf.all.accept_source_route" = 0;
          "net.ipv6.conf.default.accept_source_route" = 0;
          # Reverse path filtering causes the kernel to do source validation of
          "net.ipv6.conf.all.forwarding" = 0;
          "net.ipv6.conf.all.accept_ra" = 0;
          "net.ipv6.conf.default.accept_ra" = 0;

          ## TCP hardening
          # Prevent bogus ICMP errors from filling up logs.
          "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

          # Userspace
          # restrict usage of ptrace
          "kernel.yama.ptrace_scope" = 2;

          # ASLR memory protection (64-bit systems)
          "vm.mmap_rnd_bits" = 32;
          "vm.mmap_rnd_compat_bits" = 16;

          # only permit symlinks to be followed when outside of a world-writable sticky directory
          "fs.protected_symlinks" = 1;
          "fs.protected_hardlinks" = 1;
          # Prevent creating files in potentially attacker-controlled environments
          "fs.protected_fifos" = 2;
          "fs.protected_regular" = 2;

          # Randomize memory
          "kernel.randomize_va_space" = 2;
          # Exec Shield (Stack protection)
          "kernel.exec-shield" = 1;

          ## TCP optimization
          # TCP Fast Open is a TCP extension that reduces network latency by packing
          # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
          # both incoming and outgoing connections:
          "net.ipv4.tcp_fastopen" = 3;
          # Bufferbloat mitigations + slight improvement in throughput & latency
          "net.ipv4.tcp_congestion_control" = "bbr";
          "net.core.default_qdisc" = "cake";
        };

        blacklistedKernelModules = [
          # Obscure network protocols
          "dccp" # Datagram Congestion Control Protocol
          "sctp" # Stream Control Transmission Protocol
          "rds" # Reliable Datagram Sockets
          "tipc" # Transparent Inter-Process Communication
          "n-hdlc" # High-level Data Link Control
          "ax25" # Amateur X.25
          "netrom" # NetRom
          "x25" # X.25
          "rose"
          "decnet"
          "econet"
          "af_802154" # IEEE 802.15.4
          "ipx" # Internetwork Packet Exchange
          "appletalk"
          "psnap" # SubnetworkAccess Protocol
          "p8023" # Novell raw IEE 802.3
          "p8022" # IEE 802.3
          "can" # Controller Area Network
          "atm"

          # Old or rare or insufficiently audited filesystems
          "adfs"
          "affs"
          "bfs"
          "befs"
          "cramfs"
          "efs"
          "erofs"
          "exofs"
          "freevxfs"
          "f2fs"
          "hfs"
          "hfsplus"
          "hpfs"
          "jffs2"
          "jfs"
          "minix"
          "nilfs2"
          "omfs"
          "qnx4"
          "qnx6"
          "sysv"
          "ufs"

          # firewire
          "firewire-core"
          "firewire_core"
          "firewire-ohci"
          "firewire_ohci"
          "firewire_sbp2"
          "firewire-sbp2"
          "firewire-net"
        ];

        loader = bootloader;
      };
    };
}
