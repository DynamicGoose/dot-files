{
  inputs,
  config,
  pkgs,
  ...
}: let
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [
    ./hardware-configuration.nix
    ./device-specific.nix
    (import "${inputs.home-manager}/nixos")
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  # Bootloader configured in device-specific.nix
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = ["ntfs"];

  # Networking
  networking = {
    # Host name configured in device-specific.nix

    # Allow port 8000 for simple-http-server
    firewall.allowedTCPPorts = [
      8000
    ];

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  # Set time zone
  time.timeZone = "Europe/Berlin";

  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Console keymap
  console.keyMap = "de";

  # Fonts
  fonts = {
    fontconfig.defaultFonts = {
      serif = ["DejaVu Serif"];
      sansSerif = ["Ubuntu Nerd Font"];
      monospace = ["JetBrainsMono NF"];
    };

    packages = with pkgs; [
      jetbrains-mono
      nerdfonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };

  # Hardware
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    pulseaudio.enable = false;
    graphics.enable = true;
  };
  powerManagement.cpuFreqGovernor = "performance";

  # Security
  security = {
    rtkit.enable = true;
    polkit.enable = true;

    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };

    pam.loginLimits = [
      {
        domain = "*";
        item = "rtprio";
        type = "-";
        value = 99;
      }
      {
        domain = "*";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "*";
        item = "nofile";
        type = "-";
        value = "99999";
      }
    ];
  };

  # User config
  users.defaultUserShell = pkgs.zsh;
  users.users = {
    gezaa = {
      isNormalUser = true;
      description = "Géza Ahsendorf";
      extraGroups = ["networkmanager" "wheel" "audio"];
    };
  };

  # Services
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    gpm.enable = true;
    gvfs.enable = true;
    printing.enable = true;
  };

  # NixPkgs
  nixpkgs.config.allowUnfree = true;

  # Environment
  environment.shells = with pkgs; [zsh bash];
  # electron apps should use Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xkb";
  };
  environment.systemPackages = with pkgs; [
    adwaita-qt6
    ani-cli
    audacity
    bespokesynth
    binsider
    blender
    btop
    nemo
    fastfetch
    firefox-wayland
    geogebra6
    gimp
    git
    glibc
    guitarix
    gxplugins-lv2
    killall
    krita
    libgcc
    libreoffice
    lutris
    manga-cli
    musescore
    nodePackages.typescript
    nodejs_20
    obsidian
    prismlauncher
    protonup-qt
    python3
    qsyncthingtray
    rustup
    signal-desktop
    spotify
    telegram-desktop
    thunderbird
    vesktop
    vsce
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

  # QT
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  # Virtualisation
  virtualisation.libvirtd.enable = true;

  # Programs
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    dconf.enable = true;
    evince.enable = true;
  
    virt-manager.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
    ssh.askPassword = "";
  };

  # System
  system = {
    stateVersion = "24.05";
  };

  # Home-Manager
  home-manager.useGlobalPkgs = true;
  home-manager.users.gezaa = {pkgs, ...}: {
    # zsh
    programs.zsh = {
      enable = true;
      history = {
        size = 1000;
        save = 1000;
      };

      autocd = true;
      defaultKeymap = "emacs";

      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
      };

      initExtra = ''
        autoload -Uz vcs_info
        setopt prompt_subst
        zstyle ':vcs_info:*' actionformats ' %F{3}-> %F{4}%f%F{4}%s%F{255}:%F{5}%b|%F{4}%a%F{3}%u%f'
        zstyle ':vcs_info:*' formats ' %F{3}-> %F{4}%f%F{4}%s%F{255}:%F{6}%b%f'
        zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
        precmd () { vcs_info }
        export PS1='%~/''${vcs_info_msg_0_}%F{1} ❯%F{255} '
      '';
    };

    # Cursor
    home.pointerCursor = {
      name = "graphite-dark";
      package = pkgs.graphite-cursors;
      size = 24;
      gtk.enable = true;
    };

    # GTK
    gtk = {
      enable = true;
      iconTheme.name = "Papirus-Dark";
      iconTheme.package = pkgs.papirus-icon-theme;
      theme.name = "Graphite-Dark";
      theme.package = pkgs.graphite-gtk-theme.override {tweaks = ["black"];};
    };

    # Helix
    programs.helix = {
      enable = true;

      settings = {
        theme = "dark_high_contrast";

        editor = {
          mouse = false;
          line-number = "relative";
          color-modes = true;
        };

        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "block";
        };

        editor.indent-guides = {
          render = true;
          character = "▏";
          skip-levels = 1;
        };

        editor.soft-wrap = {
          enable = true;
          max-wrap = 25;
          max-indent-retain = 0;
          wrap-indicator = "▷ ";
        };
      };
    };

    services.syncthing = {
      enable = true;
      extraOptions = ["--gui-apikey=gezaa"];
    };

    # Dconf
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    home.stateVersion = "23.05";
  };
}
