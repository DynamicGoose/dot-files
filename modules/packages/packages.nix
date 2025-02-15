{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ani-cli
    audacity
    binsider
    btop
    cheese
    discord-canary
    fastfetch
    firefox-wayland
    gamemode
    gamescope
    gedit
    gimp
    git
    glibc
    gmetronome
    gnome-disk-utility
    gnome-clocks
    gnome-solanum
    guitarix
    gxplugins-lv2
    helvum
    heroic
    imv
    killall
    krita
    libgcc
    libreoffice
    lutris
    manga-cli
    mission-center
    mpv
    musescore
    obsidian
    prismlauncher
    protonup-qt
    pwvucontrol
    python3
    python3Packages.jedi-language-server
    r2modman
    ruff
    rustup
    sidequest
    signal-desktop
    spotify
    stc-cli
    tealdeer
    telegram-desktop
    thunderbird
    vscodium
    wget
    wineWowPackages.waylandFull
    yabridge
    yabridgectl
    zapzap
    zed-editor.fhs
    zoom-us
    zrythm
    zulu
    zulu17
  ];
}
