{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    (yabridge.override { wine = wineWowPackages.waylandFull; })
    (yabridge.override { wine = wineWowPackages.waylandFull; })
  ];
}
