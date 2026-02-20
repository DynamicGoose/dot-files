{
  pkgs,
  inputs,
  system,
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
    firefox
    freecad
    gamemode
    gedit
    gimp3-with-plugins
    git
    gitui
    gnome-disk-utility
    imv
    inputs.better-soundcloud.packages.${system}.default
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
    vesktop
    wasistlos
    wget
    wineWow64Packages.waylandFull
    # yabridge
    # yabridgectl
  ];
}
