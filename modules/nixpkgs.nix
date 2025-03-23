{ config, lib, pkgs, ... }: {
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [
      (final: prev: lib.packagesFromDirectoryRecursive {
          callPackage = pkgs.callPackage;
          directory = ../pkgs;
        })
        # graphite-kde-theme-black = prev.callPackage ../pkgs/by-name/gr/graphite-kde-theme-black {
        #   kdeclarative = pkgs.libsForQt5.kdeclarative;
        #   plasma-framework = pkgs.libsForQt5.plasma-framework;
        #   plasma-workspace = pkgs.libsForQt5.plasma-workspace;
        # };
        # bdp-fonts = prev.callPackage ../pkgs/by-name/bd/bdp-fonts { };
    ];
  };
}
