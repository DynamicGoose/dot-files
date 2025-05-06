{ pkgs }:
{
  default = import ./shell.nix { inherit pkgs; };
  nix = import ./nix.nix { inherit pkgs; };
  rust = import ./rust.nix { inherit pkgs; };
  haskell = import ./haskell.nix { inherit pkgs; };
  python = import ./python.nix { inherit pkgs; };
}
