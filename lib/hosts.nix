{ self, inputs, ... }:
let
  mkHost =
    hostDir:
    {
      system ? "x86_64-linux",
      hostname ? hostDir,
      username ? "user",
      userDescription ? "Default User",
    }:
    inputs.nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit
          inputs
          self
          hostname
          username
          userDescription
          system
          ;
      };
      modules = [
        inputs.home-manager.nixosModules.home-manager

        "${self}/default.nix"
        "${self}/hosts/${hostDir}"
      ];
    };
in
{
  mkHost = mkHost;
  genHosts = builtins.mapAttrs mkHost;
}
