{
  pkgs,
  lib,
  system,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    lib.mkIf (system == "x86_64-linux") [
      spotify
      pkgsRocm.blender
    ];
}
