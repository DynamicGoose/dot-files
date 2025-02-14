{ config, pkgs, ... }: {
  environment.systemPackages = [
    pkgs.nemo-with-extensions
    pkgs.xarchiver
  ];

  services.gvfs.enable = true;
}
