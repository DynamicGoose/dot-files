{ config, lib, inputs, ... }: {
  options.modules.virtualisation = {
    enable = lib.mkEnableOption "enable virtualisation" {
      default = true;
    };
    virt-manager.enable = lib.mkEnableOption "enable virt-manager" {
      default = true;
    };
  };

  config = lib.mkIf (config.modules.virtualisation.enable) {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = config.modules.virtualisation.virt-manager.enable;
    programs.dconf.enable = true;
    
    home-manager.users.${config.modules.users.username} = { config, ... }: {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };      
      };
    };
  };
}
