{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alsa-scarlett-gui
    audacity
    # baobab
    btop
    decibels
    # delfin (jellyfin client)
    # easytag
    easyeffects
    fastfetch
    # fluxer
    freecad
    gamemode
    gedit
    gimp3-with-plugins
    git
    gitui
    gnome-disk-utility
    imv
    karere
    keepassxc
    krita
    # kicad
    libreoffice-fresh
    librewolf
    marksman
    musescore
    obsidian
    # pkgsRocm.blender
    (prismlauncher.override {
      jdks = [
        temurin-bin
        temurin-bin-25
      ];
    })
    psst
    # r2modman
    resources
    scarlett2
    # sidequest
    signal-desktop
    sound-juicer
    teams-for-linux
    telegram-desktop
    thunderbird
    totem
    vesktop
    wget
    # wineWow64Packages.waylandFull
    # yabridge
    # yabridgectl
  ];
}
