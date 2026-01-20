{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    openFirewall = true;
    defaultRuntime = true;
    autoStart = true;
    steam.importOXRRuntimes = true;
    config = {
      enable = true;
      json = {
        scale = 0.6;
        bitrate = 175000000;
        encoder = "vulkan";
        encoders = [
          {
            codec = "h265";
            encoder = "vulkan";
            height = 0.25;
            width = 0.5;
            offset_x = 0.5;
            offset_y = 0.0;
          }
          {
            codec = "h265";
            encoder = "vulkan";
            height = 0.3;
            width = 0.5;
            offset_x = 0.0;
            offset_y = 0.7;
          }
          {
            codec = "h265";
            encoder = "vulkan";
            height = 0.7;
            width = 0.5;
            offset_x = 0.0;
            offset_y = 0.0;
          }
          {
            codec = "h265";
            encoder = "vulkan";
            height = 0.75;
            width = 0.5;
            offset_x = 0.5;
            offset_y = 0.25;
          }
        ];

        application = [ pkgs.wayvr ];
      };
    };
  };
}
