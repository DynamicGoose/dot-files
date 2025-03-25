{ config, lib, inputs, username, ... }: {
  options.modules.virtualisation = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    virt-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf (config.modules.virtualisation.enable) {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = config.modules.virtualisation.virt-manager.enable;
    programs.dconf.enable = true;
    
    home-manager.users.${username} = { config, ... }: {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };      
      };
    };
  };
}
