{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-console # mobile-friendly terminal
  ];
}
