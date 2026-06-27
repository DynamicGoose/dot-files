{ pkgs }:
pkgs.mkShell {
  name = "typst-dev";
  packages = with pkgs; [
    typst
    typstyle
    tinymist
  ];
}
