{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    nixfmt-tree
    nixfmt-rfc-style
    nil
  ];
  shellHook = ''
    export IN_NIX_DEVELOP=1
    ${pkgs.zsh}/bin/zsh
    exit
  '';
}
