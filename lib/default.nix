{ self, inputs, ... }: let
  mkHost = hostDir: {
    arch ? "x86_64-linux",
    hostname ? hostDir,
    username ? "user",
    userDescription ? "Default User",
    extraModules ? [],
  }: inputs.nixpkgs.lib.nixosSystem {
    system = arch;
    specialArgs = {
      inherit
        inputs
        self
        hostname
        username
        userDescription
        ;
    };
    modules = [
      inputs.preservation.nixosModules.preservation
      inputs.home-manager.nixosModules.home-manager
      inputs.niri.nixosModules.niri

      "${self}/default.nix"
      "${self}/hosts/${hostDir}"
    ];
  };
in {
  genHosts = builtins.mapAttrs mkHost;
}
