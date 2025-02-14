{ config, pkgs, ... }: {
  environment.systemPackages = [
    pkgs.nemo-with-extensions
    pkgs.xarchiever
  ];

  programs.gvfs.enable = true;
}
