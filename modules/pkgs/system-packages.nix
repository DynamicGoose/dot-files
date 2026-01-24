{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-scarlett-gui
    audacity
    # baobab
    btop
    decibels
    # delfin (jellyfin client)
    # easytag
    fastfetch
    firefox
    freecad
    gamemode
    gedit
    gimp3-with-plugins
    git
    gitui
    gnome-disk-utility
    imv
    kicad
    libreoffice
    musescore
    obsidian
    pkgsRocm.blender
    (prismlauncher.override {
      jdks = [
        temurin-bin
        temurin-bin-25
      ];
    })
    # r2modman
    resources
    scarlett2
    sidequest
    signal-desktop
    sound-juicer
    spotify
    telegram-desktop
    thunderbird
    totem
    vdhcoapp
    vesktop
    wasistlos
    wget
    wineWowPackages.waylandFull
    (yabridge.override { wine = wineWowPackages.waylandFull; })
    (yabridgectl.override { wine = wineWowPackages.waylandFull; })
  ];
}
