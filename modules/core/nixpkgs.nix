{
  lib,
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
      # temp obs virtual cam fix until https://nixpk.gs/pr-tracker.html?pr=421175
      (final: prev: {
        obs-studio = prev.obs-studio.overrideAttrs (old: rec {
          version = "31.0.4";
          src = prev.fetchFromGitHub {
            owner = "obsproject";
            repo = "obs-studio";
            rev = version;
            hash = "sha256-YxBPVXin8oJlo++oJogY1WMamIJmRqtSmKZDBsIZPU4=";
            fetchSubmodules = true;
          };
        });
      })
    ];
  };
}
