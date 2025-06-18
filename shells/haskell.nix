{ pkgs }:
pkgs.mkShell {
  name = "haskell-dev";
  buildInputs = with pkgs; [
    ghc
    haskell-language-server
    stack
  ];
}
