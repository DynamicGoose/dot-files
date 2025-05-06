{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    ghc
    haskell-language-server
    stack
  ];
  shellHook = ''
    export IN_NIX_DEVELOP=1
    ${pkgs.zsh}/bin/zsh
    exit
  '';
}
