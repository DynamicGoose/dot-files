{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ani-cli
    audacity
    baobab
    blender-hip
    # brasero - broken bc of dvdauthor build failure
    btop
    cheese
    decibels
    # delfin (jellyfin client)
    dino
    easytag
    element-desktop
    fastfetch
    firefox-wayland
    gamemode
    gamescope
    gedit
    gimp3-with-plugins
    git
    gitui
    gmetronome
    gnome-disk-utility
    gnome-clocks
    gnome-solanum
    heroic
    imv
    killall
    krita
    libreoffice
    manga-cli
    musescore
    obsidian
    prismlauncher
    r2modman
    recordbox
    resources
    signal-desktop
    # sound-juicer - broken bc of dvdauthor build failure
    spotify
    stc-cli
    telegram-desktop
    thunderbird
    totem
    uutils-coreutils-noprefix
    vdhcoapp
    vesktop
    wget
    wineWowPackages.waylandFull
    zapzap
    zoom-us
    # zrythm
    temurin-bin-24
    zulu8
  ];
}
