{ pkgs }:
let
  libPath =
    with pkgs;
    lib.makeLibraryPath [
      # add dependencies
    ];
in
pkgs.mkShell {
  name = "rust-dev";

  nativeBuildInputs = with pkgs; [
    rustc
    cargo
    gcc
    rust-analyzer
    rustfmt
    clippy
  ];

  buildInputs = with pkgs; [
    pkg-config
  ];

  LD_LIBRARY_PATH = "${libPath}";
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}
