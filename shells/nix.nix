{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    nixfmt-tree
    nixfmt-rfc-style
    nil
  ];
  shellHook = ''
    ${pkgs.nushell}/bin/nu
    exit
  '';
}
