{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;

    # extra binary caches
    substituters = [ ];
    trusted-public-keys = [ ];
  };
}
