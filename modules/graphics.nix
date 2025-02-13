{ config, pkgs, lib, ...}: let
  graphicsConfig = if (config.modules.graphics.type == "amd") then {
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
  }; else if (config.modules.graphics.type == "intel") then {
    hardware.graphics.extraPackages = with pkgs; [
      intel-media-sdk
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  }; else {};
in {
  options.modules.graphics.type = lib.mkOption {
    type = lib.types.str;
    default = "amd";
  };

  config = graphicsConfig;
}
