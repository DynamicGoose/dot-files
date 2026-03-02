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
            grub = {
              enable = true;
              device = "/dev/sda";
              splashImage = null;
            };
          }
        else if (config.modules.boot.deviceType == "removable") then
          {
            efi = {
              canTouchEfiVariables = false;
              efiSysMountPoint = "/boot";
            };
            grub = {
              enable = true;
              efiSupport = true;
              efiInstallAsRemovable = true;
              device = "nodev";
              splashImage = null;
              # UUID needs to be adjusted on new install
              extraEntries = ''
                menuentry "Netboot.xyz" {
                  insmod part_gpt
                  insmod ext2
                  insmod chain
                  search --no-floppy --fs-uuid --set root aa18d19c-9806-417e-be19-71065c50d455
                  chainloader ${pkgs.netbootxyz-efi}
                }
              '';
            };
          }
        else
          {
            efi = {
              canTouchEfiVariables = true;
              efiSysMountPoint = "/boot";
            };
            grub = {
              enable = true;
              efiSupport = true;
              device = "nodev";
              splashImage = null;
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
        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "loglevel=3"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "udev.log_priority=3"
        ];
        loader = bootloader;
      };
    };
}
