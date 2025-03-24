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
 
  # Hostname
  networking.hostName = "desktop-gezaa";

  home-manager.users.${config.modules.users.username} = { pkgs, ... }: {
    programs.niri.settings = {
      spawn-at-startup = [{ command = ["cpupower-gui" "-p"]; }];
    };
  };
}
