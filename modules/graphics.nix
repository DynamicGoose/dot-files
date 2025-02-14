{ config, pkgs, lib, ...}: {
  options.modules.graphics.type = lib.mkOption {
    type = lib.types.str;
    default = "amd";
  };

  config = let
    type = config.modules.graphics.type;
  in {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    
    # AMD
    hardware.amdgpu = lib.mkIf (type == "amd") {
      opencl.enable = true;
      initrd.enable = true;
    };
    # Lact (amdgpu control-panel)
    environment.systemPackages = lib.mkIf (type == "amd") [pkgs.lact];
    systemd.services.lact = lib.mkIf (type == "amd") {
      description = "AMDGPU Control Daemon";
      after = ["multi-user.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${pkgs.lact}/bin/lact daemon";
      };
      enable = true;
    };
    # overclocking kernel param
    boot.kernelParams = lib.mkIf (type == "amd") ["amdgpu.ppfeaturemask=0xffffffff"];

    # Intel
    hardware.graphics.extraPackages = lib.mkIf (type == "intel") [
      pkgs.intel-media-sdk
      pkgs.intel-media-driver
      pkgs.intel-vaapi-driver
      pkgs.libvdpau-va-gl
    ];
    environment.sessionVariables = lib.mkIf (type == "intel") { LIBVA_DRIVER_NAME = "iHD"; };
  };
}
