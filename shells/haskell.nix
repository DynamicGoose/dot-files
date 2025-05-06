{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    ghc
    haskell-language-server
    stack
  ];
  shellHook = ''
    export IN_NIX_DEVELOP=1
    export NIX_ENV_NAME=haskell
    ${pkgs.zsh}/bin/zsh
    exit
  '';
}
