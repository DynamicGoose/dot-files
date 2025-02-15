{ config, pkgs, ... }: {
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [
      # xwayland-satellite 0.5.1 breaks "Halo: The Master Chief Collection"
      (final: prev: {
        xwayland-satellite = prev.xwayland-satellite.overrideAttrs (_:rec {
          version = "0.5";

          src = prev.fetchFromGitHub {
            owner = "Supreeeme";
            repo = "xwayland-satellite";
            tag = "v${version}";
            hash = "sha256-nq7bouXQXaaPPo/E+Jbq+wNHnatD4dY8OxSrRqzvy6s=";
          };

          cargoHash = "sha256-1tt7YNornw9U9FRdsRkdWx3Al3FZtvtCBXn9Pln+gk4=";
        });
      })
    ];
  };
}
