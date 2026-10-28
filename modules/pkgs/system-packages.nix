{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alsa-scarlett-gui
    # BROKEN: audacity
    # baobab
    # bambu-studio
    # bottles - broken
    btop
    decibels
    # delfin (jellyfin client)
    # easytag
    easyeffects
    fastfetch
    # fluxer
    # freecad
    gamemode
    gajim
    gedit
    gimp3-with-plugins
    git
    gitui
    gnome-maps
    imv
    (inkscape-with-extensions.override {
      inkscapeExtensions = [ inkscape-extensions.textext ];
    })
    karere
    keepassxc
    krita
    # kicad
    libreoffice
    librewolf
    marksman
    # BROKEN: musescore
    # pkgsRocm.blender
    prismlauncher
    # psst
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
