{ pkgs, ... }:
{
  fonts = {
    fontconfig.defaultFonts = {
      serif = [ "DejaVu Serif" ];
      sansSerif = [ "Ubuntu Nerd Font" ];
      monospace = [ "FiraCode Nerd Font" ];
    };

    packages = with pkgs; [
      jetbrains-mono
      dejavu_fonts
      nerd-fonts.ubuntu
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      comic-mono
      dancing-script
      bdp-fonts
    ];

    enableDefaultPackages = true;
  };
}
