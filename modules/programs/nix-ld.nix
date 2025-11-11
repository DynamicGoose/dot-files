{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.stdenv.cc.cc.lib
      pkgs.libsForQt5.qt5.qtbase
    ];
  };
}
