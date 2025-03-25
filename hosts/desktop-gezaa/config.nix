{
  inputs,
  config,
  pkgs,
  username,
  ...
}: {
  modules = {
    programs.waybar.desktop = true;
    services.hypridle.desktop = true;
  };
  
  # CpuFreqGov performance mode
  powerManagement.cpuFreqGovernor = "performance";
 
  home-manager.users.${username} = { pkgs, ... }: {
    programs.niri.settings = {
      spawn-at-startup = [{ command = ["cpupower-gui" "-p"]; }];
    };
  };
}
