{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/bootloader/grub_uefi.nix
    ../../modules/graphics/amd.nix
    ../../modules/power-management/gui_only.nix
    ../../modules/home-manager/desktop.nix
  ];

  # CpuFreqGov performance mode
  powerManagement.cpuFreqGovernor = "performance";
 
  # filesystem config and nix store on other device
  fileSystems = {
    "/nix" = {
      device = "/dev/disk/by-label/nix";
      fsType = "ext4";
      neededForBoot = true;
      options = ["noatime"];
    };
    "/run/media/gezaa/HDD01" = {
      device = "/dev/disk/by-label/HDD01";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };
    "/run/media/gezaa/SSD02" = {
      device = "/dev/disk/by-label/SSD02";
      fsType = "ext4";
      options = ["uid=1000"];
    };
  };

  # Hostname
  networking.hostName = "desktop-gezaa";
}
