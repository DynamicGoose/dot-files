{ config, lib, inputs, ... }: {
  options.modules.virtualisation = {
    disable = lib.mkEnableOption "disable virtualisation";
    virt-manager.disable = lib.mkEnableOption "disable virt-manager";
  };

  config = lib.mkIf (!config.modules.virtualisation.disable) {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = !config.modules.virtualisation.virt-manager.disable;
    programs.dconf.enable = true;
    
    home-manager.users.gezaa = { config, ... }: {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };      
      };
    };
  };
}
