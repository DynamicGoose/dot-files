{ self, inputs, ... }:
let
  hosts = import ./hosts.nix {
    self = self;
    inputs = inputs;
  };
  systems = import ./systems.nix {
    nixpkgs = inputs.nixpkgs;
  };
  vm = import ./vm.nix {
    inputs = inputs;
  };
in
{
  inherit (hosts) mkHost genHosts;
  inherit (systems) eachSystem;
  inherit (vm) mkVMApp;
}
