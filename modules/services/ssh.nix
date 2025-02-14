{ config, lib, ... }: {
  options.modules.services.ssh = {
    disable = lib.mkEnableOption "disable ssh";
    server = lib.mkEnableOption "always run ssh in background";
  };
  
  config.services.openssh = lib.mkIf (!config.modules.services.ssh.disable) {
    enable = true;
    # only start when needed (if not server)
    startWhenNeeded = !config.modules.services.ssh.server;
    openFirewall = true;
  };
}
