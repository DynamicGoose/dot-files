{ config, lib, ... }: {
  options.modules.services.ssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    server = lib.mkEnableOption "always run ssh in background";
  };
  
  config.services.openssh = lib.mkIf (config.modules.services.ssh.enable) {
    enable = true;
    # only start when needed (if not server)
    startWhenNeeded = !config.modules.services.ssh.server;
    openFirewall = true;
  };
}
