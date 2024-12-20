{pkgs ? import <nixpkgs> {}}:
let
  libPath = with pkgs; lib.makeLibraryPath [
    # add dependancies
  ];
in
with pkgs; mkShell {
  buildInputs = [
    rustup
    pkg-config
  ];
  LD_LIBRARY_PATH = "${libPath}";
}
