{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    (yabridge.override { wine = wineWowPackages.waylandFull; })
    (yabridgectl.override { wine = wineWowPackages.waylandFull; })
  ];
}
