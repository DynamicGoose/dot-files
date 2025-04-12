{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.modules.graphics = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    type = lib.mkOption {
      type = lib.types.str;
      default = "amd";
    };
    nvidia = {
      driverPackage = lib.mkOption {
        default = config.boot.kernelPackages.nvidiaPackages.latest;
      };
      rtx20 = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      hybrid = {
        enable = lib.mkEnableOption "enable hyprid mode for laptops";
        # https://nixos.wiki/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_.28Mandatory.29
        intelBusId = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
        nvidiaBusId = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
        amdBusId = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
      };
    };
  };

  config =
    let
      type = config.modules.graphics.type;
    in
    lib.mkIf (config.modules.graphics.enable) {
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
      environment.systemPackages = lib.mkIf (type == "amd") [ pkgs.lact ];
      systemd.services.lact = lib.mkIf (type == "amd") {
        description = "AMDGPU Control Daemon";
        after = [ "multi-user.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.lact}/bin/lact daemon";
        };
        enable = true;
      };
      # overclocking kernel param
      boot.kernelParams = lib.mkIf (type == "amd") [ "amdgpu.ppfeaturemask=0xffffffff" ];

      # Intel
      hardware.graphics.extraPackages = lib.mkIf (type == "intel") [
        pkgs.intel-media-sdk
        pkgs.intel-media-driver
        pkgs.intel-vaapi-driver
        pkgs.libvdpau-va-gl
      ];
      environment.sessionVariables = lib.mkIf (type == "intel") { LIBVA_DRIVER_NAME = "iHD"; };

      # Nvidia
      services.xserver.videoDrivers = lib.mkIf (type == "nvidia") [ "nvidia" ];
      hardware.nvidia = lib.mkIf (type == "nvidia") {
        modesetting.enable = true;
        open = config.modules.graphics.nvidia.rtx20;
        nvidiaSettings = true;
        package = config.modules.graphics.nvidia.driverPackage;

        prime = lib.mkIf (config.modules.graphics.nvidia.hybrid.enable) {
          sync.enable = true;

          intelBusId = config.modules.graphics.nvidia.hyprid.intelBusId;
          nvidiaBusId = config.modules.graphics.nvidia.hyprid.nvidiaBusId;
          amdgpuBusId = config.modules.graphics.nvidia.hyprid.amdBusId;
        };
      };
    };
}
