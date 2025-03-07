{ config, pkgs, ... }: {
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [
      (final: prev: {
        graphite-kde-theme-black = prev.callPackage ../packages/graphite-kde-theme-black.nix {
          kdeclarative = pkgs.libsForQt5.kdeclarative;
          plasma-framework = pkgs.libsForQt5.plasma-framework;
          plasma-workspace = pkgs.libsForQt5.plasma-workspace;
        };
      })
    ];
  };
}
