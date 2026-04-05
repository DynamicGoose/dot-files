{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kitty
    phosh-mobile-settings
    nautilus
  ];
}
