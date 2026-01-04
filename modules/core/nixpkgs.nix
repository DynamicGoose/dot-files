{
  lib,
  inputs,
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
      inputs.nix-cachyos-kernel.overlays.pinned
      # fix kicad theming
      (final: prev: {
        kicad = prev.kicad.overrideAttrs (oldAttrs: {
          postInstall = ''
            mkdir -p $out/share
            cp -rf ${oldAttrs.base}/share/applications $out/share/applications
            ln -s ${oldAttrs.base}/share/icons $out/share/icons
            ln -s ${oldAttrs.base}/share/mime $out/share/mime
            ln -s ${oldAttrs.base}/share/metainfo $out/share/metainfo
            substituteInPlace $out/share/applications/org.kicad.eeschema.desktop \
              --replace "eeschema %f" "env GTK_THEME=Adwaita:dark eeschema %f"
            substituteInPlace $out/share/applications/org.kicad.gerbview.desktop \
              --replace "gerbview %F" "env GTK_THEME=Adwaita:dark gerbview %F"
            substituteInPlace $out/share/applications/org.kicad.kicad.desktop \
              --replace "kicad %f" "env GTK_THEME=Adwaita:dark kicad %f"
            substituteInPlace $out/share/applications/org.kicad.pcbnew.desktop \
              --replace "pcbnew %f" "env GTK_THEME=Adwaita:dark pcbnew %f"
          '';
        });
      })
    ];
  };
}
