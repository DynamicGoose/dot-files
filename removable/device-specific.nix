{ inputs, config, pkgs, ... }:
{
  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
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
  };

  # Host name
  networking.hostName = "usb-gezaa";
}
