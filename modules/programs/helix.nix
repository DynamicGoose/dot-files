{
  pkgs,
  ...
}:
{
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  environment.systemPackages = [ pkgs.helix-wrapped ];
}
