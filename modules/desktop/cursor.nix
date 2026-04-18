{
  pkgs,
  # username,
  ...
}:
let
  defaultIndexTheme = pkgs.writeTextFile {
    name = "index.theme";
    destination = "/share/icons/default/index.theme";
    text = ''
      [Icon Theme]
      Name=Default
      Comment=Default Icon Theme
      Inherits=graphite-dark
    '';
  };
in
{
  environment.systemPackages = [
    pkgs.graphite-cursors
    defaultIndexTheme
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "graphite-dark";
    XCURSOR_SIZE = 24;
    XCURSOR_PATH = [
      "${pkgs.graphite-cursors}/share/icons"
      "${defaultIndexTheme}/share/icons"
    ];
  };
}
