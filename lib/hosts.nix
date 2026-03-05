{ self, inputs, ... }:
let
  mkHost =
    hostName:
    {
      system ? "x86_64-linux",
      hostDir ? hostName,
      username ? "user",
      userDescription ? "Default User",
      includeModules ? [
        inputs.home-manager.nixosModules.home-manager
        "${self}/default.nix"
        "${self}/hosts/${hostDir}"
      ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit
          inputs
          self
          hostName
          hostDir
          username
          userDescription
          system
          ;
      };
      modules = includeModules;
    };
in
{
  mkHost = mkHost;
  genHosts = builtins.mapAttrs mkHost;
}
