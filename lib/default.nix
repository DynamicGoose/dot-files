{
  self,
  inputs,
  lib,
  ...
}:
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
  attrs-helpers = import ./attrs-helpers.nix { lib = lib; };
in
{
  inherit (hosts) mkHost genHosts;
  inherit (systems) eachSystem;
  inherit (systems) pkgsFor;
  inherit (vm) mkVMApp;
  inherit (attrs-helpers) mergeAttrsRecursive;
}
