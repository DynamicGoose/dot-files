{ pkgs }:
pkgs.mkShell {
  name = "dot-files";
  packages = with pkgs; [
    nixfmt-tree
    nixfmt-rfc-style
    nil
  ];
}
