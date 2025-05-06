{ pkgs }:
let
  libPath =
    with pkgs;
    lib.makeLibraryPath [
      # add dependencies
    ];
in
pkgs.mkShell {
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

  shellHook = ''
    export IN_NIX_DEVELOP=1
    ${pkgs.zsh}/bin/zsh
    exit
  '';

  LD_LIBRARY_PATH = "${libPath}";
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}
