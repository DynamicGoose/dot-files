{ pkgs }:
pkgs.mkShell {
  name = "nix-dev";
  packages = with pkgs; [
    nixfmt-tree
    nixfmt-rfc-style
    nil
  ];
}
