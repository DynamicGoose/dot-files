{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    nixfmt-tree
    nixfmt-rfc-style
    nil
  ];
  shellHook = ''
    export IN_NIX_DEVELOP=1
    zsh
  '';
}
