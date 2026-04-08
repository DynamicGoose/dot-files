{
  wrapper-modules,
  pkgs,
}:
let
  starship-config = pkgs.writeText "starship.toml" (builtins.readFile ./starship.toml);
in
wrapper-modules.lib.wrapPackage {
  inherit pkgs;
  package = pkgs.starship;
  env = {
    STARSHIP_CONFIG = "${starship-config}";
  };
  constructFiles.generatedConfig = {
    content = builtins.readFile ./starship.toml;
    relPath = "starship.toml";
  };
}
