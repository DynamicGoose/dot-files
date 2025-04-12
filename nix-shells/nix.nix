{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    nixfmt-tree
    nixfmt-rfc-style
    nil
  ];
}
