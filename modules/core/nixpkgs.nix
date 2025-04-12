{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (
        final: prev:
        lib.packagesFromDirectoryRecursive {
          callPackage = prev.callPackage;
          directory = ../../pkgs;
        }
      )
    ];
  };
}
