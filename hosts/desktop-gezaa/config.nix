{
  inputs,
  config,
  pkgs,
  ...
}: {
  modules = {
    programs.waybar.desktop = true;
    services.hypridle.desktop = true;
  };
  
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
    };
  };
  
  # Hostname
  networking.hostName = "desktop-gezaa";

  home-manager.users.${config.modules.users.username} = { pkgs, ... }: {
    programs.niri.settings = {
      spawn-at-startup = [{ command = ["cpupower-gui" "-p"]; }];
    };
  };
}
