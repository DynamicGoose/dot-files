{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-scarlett-gui
    # ani-cli
    audacity
    baobab
    brasero
    btop
    cheese
    decibels
    # delfin (jellyfin client)
    # easytag
    # element-desktop
    fastfetch
    firefox
    freecad
    gamemode
    gedit
    gimp3-with-plugins
    git
    gitui
    gmetronome
    gnome-disk-utility
    gnome-clocks
    heroic
    imv
    kicad
    # krita
    libreoffice
    # manga-cli
    musescore
    obsidian
      pkgsRocm.blender
    (prismlauncher.override {
      jdks = [
        temurin-jre-bin-8
        temurin-jre-bin-17
        temurin-bin
        temurin-bin-25
      ];
    })
    r2modman
    recordbox
    resources
    scarlett2
    sidequest
    signal-desktop
    sound-juicer
    spotify
    telegram-desktop
    thunderbird
    totem
    uutils-coreutils-noprefix
    vdhcoapp
    vesktop
    wget
    wineWowPackages.waylandFull
    wlx-overlay-s
    (yabridge.override { wine = wineWowPackages.waylandFull; })
    (yabridgectl.override { wine = wineWowPackages.waylandFull; })
    zapzap
    zrythm
  ];
}
