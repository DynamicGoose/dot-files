{
  config,
  pkgs,
  ...
}: {
  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
  };

  # LACT (amdgpu control-panel)
  environment.systemPackages = with pkgs; [ lact ];
  # lactd service
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
  # overclocking (kernel param)
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xffffffff"];
}
