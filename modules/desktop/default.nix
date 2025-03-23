{ config, lib, ... }: {
  options.modules.desktop = {
    plasma.enable = lib.mkEnableOption "Enable Plasma 6 Desktop";
    hyprland.enable = lib.mkEnableOption "Enable Hyprland config";
    niri.enable = lib.mkEnableOption "Enable Niri config" {
      default = true;
    };
  };
  
  imports = [
    ./cursor.nix
    ./fonts.nix
    ./gtk.nix
    ./qt.nix
    lib.mkIf (options.modules.desktop.plasma.enable) ./plasma.nix
    lib.mkIf (options.modules.desktop.hyprland.enable) ./hyprland.nix
    lib.mkIf (options.modules.desktop.niri.enable) ./niri.nix
  ];
}
