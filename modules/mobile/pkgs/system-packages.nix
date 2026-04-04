{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-console # mobile-friendly terminal
    kitty
    phosh-mobile-settings
  ];
}
