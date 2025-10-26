{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ani-cli
    audacity
    baobab
    blender-hip
    brasero
    btop
    cheese
    decibels
    # delfin (jellyfin client)
    easytag
    element-desktop
    fastfetch
    firefox-wayland
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
    krita
    libreoffice
    manga-cli
    musescore
    obsidian
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
    (yabridge.override { wine = wineWowPackages.waylandFull; })
    (yabridgectl.override { wine = wineWowPackages.waylandFull; })
    zapzap
    zoom-us
    zrythm
  ];
}
