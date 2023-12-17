{ inputs, config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/device-specific.nix
      (import "${home-manager}/nixos")
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
 
  # Bootloader configured in device-specific.nix
   
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
      serif = [ "DejaVu Serif" ];
      sansSerif = [ "Ubuntu Nerd Font" ];
      monospace = [ "JetBrainsMono NF"];
    };
    
    packages = with pkgs; [
      jetbrains-mono
      nerdfonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };

  # Sound
  sound.enable = true;

  # Hardware
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    
    pulseaudio.enable = false;
    opengl.enable = true;
  };

  # Security
  security = {
    rtkit.enable = true;
    polkit.enable = true;

    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  # User config
  users.defaultUserShell = pkgs.zsh;
  users.users = {
    gezaa = {
      isNormalUser = true;
      description = "Géza Ahsendorf";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
  
  # Services
  services = {
    xserver = {
      enable = true;
      
      displayManager = {
        sessionPackages = [ pkgs.hyprland ];
        lightdm = {
          enable = true;
          background = "${pkgs.budgie.budgie-backgrounds}/share/backgrounds/budgie/apollo-11-earth.jpg";
          greeters.gtk = {
            enable = true;
            theme.package = pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; };
            theme.name = "Graphite-Dark";
            iconTheme.package = pkgs.papirus-icon-theme;
            iconTheme.name = "Papirus-Dark";
            cursorTheme.package = pkgs.graphite-cursors;
            cursorTheme.name = "graphite-gark";
            cursorTheme.size = 24;
            indicators = [];
          };
        };
      };
      
      layout = "de";
      xkbVariant = "";
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    blueman.enable = true;
    cpupower-gui.enable = true;
    gnome.gnome-keyring.enable = true;
    gpm.enable = true;
    gvfs.enable = true;
    printing.enable = true;
  };

  # Systemd
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # XDG
  xdg.portal = {
    enable = true;
    configPackages = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # NixPkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  
  nixpkgs.overlays = [
    (self: super: {
      ollama = super.ollama.overrideAttrs (oldAttrs: {
        version = "0.1.8";
      });
    })
  ];

  # Environment
  environment.shells = with pkgs; [ zsh bash ];
  environment.systemPackages = with pkgs; [
    adwaita-qt6
    bespokesynth
    blender
    brightnessctl
    btop
    cinnamon.nemo
    discord
    esbuild
    firefox-wayland
    gedit
    geogebra6
    gimp
    git
    glibc
    gnome.cheese
    gnome.gnome-disk-utility
    grim
    hyprpicker
    imv
    killall
    kitty
    kooha
    krita
    libgcc
    libreoffice
    libsForQt5.qtstyleplugin-kvantum
    lutris
    mpv
    musescore
    neofetch
    networkmanagerapplet
    nodePackages.typescript
    nodejs_20
    obsidian
    ollama
    prismlauncher
    pavucontrol
    protonup-qt
    python3
    qalculate-gtk
    rustup
    sbt
    signal-desktop
    simple-http-server
    slurp
    spotify
    swaybg
    swayidle
    swaylock-effects
    swaynotificationcenter
    syncthingtray-minimal
    tidal-hifi
    vsce
    vscodium
    wdisplays
    wget
    whatsapp-for-linux
    wineWowPackages.waylandFull
    wl-clipboard
    wl-clip-persist
    xarchiver
    zrythm
    zulu
    zulu8
  ];

  # QT
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  # Programs
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    
    dconf.enable = true;
    evince.enable = true;
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
  home-manager.users.gezaa = { pkgs, ... }: {
    # XDG
    xdg = {
      enable = true;
      configFile = {
        "kvantum" = {
          enable = true;
          target = "Kvantum/home-manager.md";
          text = ''
            # Theme
            Graphite-Dark
          '';
          onChange = "rm -rf /home/gezaa/.config/Kvantum/Graphite && cp -rf /home/gezaa/git/dot-files/Graphite /home/gezaa/.config/Kvantum/Graphite && rm -rf /home/gezaa/.config/Kvantum/kvantum.kvconfig && touch /home/gezaa/.config/Kvantum/kvantum.kvconfig && echo -e '[General]''\ntheme=GraphiteDark' >> /home/gezaa/.config/Kvantum/kvantum.kvconfig";
        };
        "qt5ct" = {
          enable = true;
          target = "qt5ct/qt5ct.conf";
          text = ''
            [Appearance]
            color_scheme_path=/nix/store/4i9q0lnzl8cr7yq0s07bd4yfbz7gc7nc-qt5ct-1.7/share/qt5ct/colors/darker.conf
            custom_palette=true
            icon_theme=Papirus-Dark
            standard_dialogs=default
            style=kvantum-dark

            [Fonts]
            fixed="Ubuntu Nerd Font,12,-1,5,50,0,0,0,0,0"
            general="Ubuntu Nerd Font,12,-1,5,50,0,0,0,0,0"

            [Interface]
            activate_item_on_single_click=1
            buttonbox_layout=0
            cursor_flash_time=1000
            dialog_buttons_have_icons=1
            double_click_interval=400
            gui_effects=@Invalid()
            keyboard_scheme=2
            menus_have_icons=true
            show_shortcuts_in_context_menus=true
            stylesheets=@Invalid()
            toolbutton_style=4
            underline_shortcut=1
            wheel_scroll_lines=3

            [SettingsWindow]
            geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\ao\0\0\x3\xff\0\0\0\0\0\0\0\0\0\0\x2\xde\0\0\x3\x1b\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\ao\0\0\x3\xff)

            [Troubleshooting]
            force_raster_widgets=1
            ignored_applications=@Invalid()
          '';
        };
        "qt6ct" = {
          enable = true;
          target = "qt6ct/qt6ct.conf";
          text = ''
            [Appearance]
            color_scheme_path=/nix/store/2jgifi5bl6qim74h2jwpdz1jwbd4qcbm-qt6ct-0.8/share/qt6ct/colors/airy.conf
            custom_palette=false
            icon_theme=Papirus-Dark
            standard_dialogs=default
            style=Adwaita-Dark

            [Fonts]
            fixed="Ubuntu Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
            general="Ubuntu Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

            [Interface]
            activate_item_on_single_click=1
            buttonbox_layout=0
            cursor_flash_time=1000
            dialog_buttons_have_icons=1
            double_click_interval=400
            gui_effects=@Invalid()
            keyboard_scheme=2
            menus_have_icons=true
            show_shortcuts_in_context_menus=true
            stylesheets=@Invalid()
            toolbutton_style=4
            underline_shortcut=1
            wheel_scroll_lines=3

            [PaletteEditor]
            geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\xc4\0\0\0\xd0\0\0\x3:\0\0\x2\xe0\0\0\0\xc4\0\0\0\xd0\0\0\x3:\0\0\x2\xe0\0\0\0\0\0\0\0\0\a\x80\0\0\0\xc4\0\0\0\xd0\0\0\x3:\0\0\x2\xe0)

            [SettingsWindow]
            geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x4\x12\0\0\x3\xff\0\0\0\0\0\0\0\0\0\0\x4\x12\0\0\x3\xff\0\0\0\0\0\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x4\x12\0\0\x3\xff)

            [Troubleshooting]
            force_raster_widgets=1
            ignored_applications=@Invalid()
          '';
        };
        "syncthingtray" = {
          enable = true;
          target = "syncthingtray/syncthingtray.ini";
          text = ''
            [General]
            v=1.4.6

            [startup]
            considerForReconnect=false
            considerLauncherForReconnect=false
            showButton=false
            showLauncherButton=false
            syncthingArgs="-no-browser -no-restart -logflags=3"
            syncthingAutostart=false
            syncthingPath=syncthing
            syncthingUnit=syncthing.service
            systemUnit=false
            tools\Process\args=
            tools\Process\autostart=false
            tools\Process\path=
            useLibSyncthing=false

            [tray]
            connections\1\apiKey=@ByteArray(gezaa)
            connections\1\authEnabled=false
            connections\1\autoConnect=true
            connections\1\devStatsPollInterval=60000
            connections\1\errorsPollInterval=30000
            connections\1\httpsCertPath=
            connections\1\label=Primary instance
            connections\1\password=
            connections\1\reconnectInterval=30000
            connections\1\requestTimeout=0
            connections\1\statusComputionFlags=59
            connections\1\syncthingUrl=http://127.0.0.1:8384
            connections\1\trafficPollInterval=5000
            connections\1\userName=
            connections\size=1
            dbusNotifications=true
            distinguishTrayIcons=false
            frameStyle=16
            ignoreInavailabilityAfterStart=15
            notifyOnDisconnect=true
            notifyOnErrors=true
            notifyOnLauncherErrors=true
            notifyOnLocalSyncComplete=false
            notifyOnNewDeviceConnects=false
            notifyOnNewDirectoryShared=false
            notifyOnRemoteSyncComplete=false
            positioning\assumedIconPos=@Point(0 0)
            positioning\useAssumedIconPosition=false
            positioning\useCursorPos=true
            preferIconsFromTheme=false
            showSyncthingNotifications=true
            showTabTexts=true
            showTraffic=true
            statusIcons="#00000000,#00000000,#ffffffff;#00000000,#00000000,#ffffaea5;#00ffffff,#00ffffff,#fffff6a5;#00ffffff,#00ffffff,#ffffffff;#00ffffff,#00ffffff,#ffa5efff;#00ffffff,#00ffffff,#ffa5efff;#00000000,#00ffffff,#ffa7a7a7;#00000000,#00000000,#ffa7a7a7"
            statusIconsRenderSize=@Size(32 32)
            statusIconsStrokeWidth=1
            tabPos=1
            trayIcons="#00000000,#00000000,#ffffffff;#00000000,#00000000,#ffffaea5;#00ffffff,#00ffffff,#fffff6a5;#00ffffff,#00ffffff,#ffffffff;#00ffffff,#00ffffff,#ffa5efff;#00ffffff,#00ffffff,#ffa5efff;#00000000,#00ffffff,#ffa7a7a7;#00000000,#00000000,#ffa7a7a7"
            trayIconsRenderSize=@Size(32 32)
            trayIconsStrokeWidth=0
            trayMenuSize=@Size(575 475)
            windowType=2

            [webview]
            customCommand=
            disabled=true
            mode=1
            qt\customfont=false
            qt\customicontheme=false
            qt\customlocale=false
            qt\custompalette=false
            qt\customstylesheet=false
            qt\customwidgetstyle=true
            qt\font="Ubuntu Nerd Font,12,-1,5,50,0,0,0,0,0"
            qt\icontheme=Papirus-Dark
            qt\iconthemepath=
            qt\locale=en_US
            qt\palette=@Variant(\0\0\0\x44\x1\x1\xff\xff\xdf\xdf\xdf\xdf\xdf\xdf\0\0\x1\x1\xff\xffMMMMMM\0\0\x1\x1\xff\xffSSSSSS\0\0\x1\x1\xff\xffGGGGGG\0\0\x1\x1\xff\xff((((((\0\0\x1\x1\xff\xff\x32\x32\x32\x32\x32\x32\0\0\x1\x1\xff\xff\xdf\xdf\xdf\xdf\xdf\xdf\0\0\x1\x1\xff\xff\xff\xff\xff\xff\xff\xff\0\0\x1\x1\xff\xff\xdf\xdf\xdf\xdf\xdf\xdf\0\0\x1\x1\xff\xff\xf\xf\xf\xf\xf\xf\0\0\x1\x1\xff\xff\xf\xf\xf\xf\xf\xf\0\0\x1\x1\xff\xff\0\0\0\0\0\0\0\0\x1\x1\xff\xff\xe0\xe0\xe0\xe0\xe0\xe0\0\0\x1\x1\xff\xff\x33\x33\x33\x33\x33\x33\0\0\x1\x1\xff\xff\0\0WW\xae\xae\0\0\x1\x1\xff\xff\xe0\xe0@@\xfb\xfb\0\0\x1\x1\xff\xff......\0\0\x1\x1\xff\xffiiiiii\0\0\x1\x1\xff\xffMMMMMM\0\0\x1\x1\xff\xffSSSSSS\0\0\x1\x1\xff\xffGGGGGG\0\0\x1\x1\xff\xff((((((\0\0\x1\x1\xff\xff\x32\x32\x32\x32\x32\x32\0\0\x1\x1\xff\xffiiiiii\0\0\x1\x1\xff\xff\xff\xff\xff\xff\xff\xff\0\0\x1\x1\xff\xffiiiiii\0\0\x1\x1\xff\xff\xf\xf\xf\xf\xf\xf\0\0\x1\x1\xff\xff\xf\xf\xf\xf\xf\xf\0\0\x1\x1\xff\xff\0\0\0\0\0\0\0\0\x1\x1\xff\xff\xe0\xe0\xe0\xe0\xe0\xe0\0\0\x1\x1\x66\x66\x33\x33\x33\x33\x33\x33\0\0\x1\x1\xff\xff\0\0WW\xae\xae\0\0\x1\x1\xff\xff\xe0\xe0@@\xfb\xfb\0\0\x1\x1\xff\xff......\0\0\x1\x1\xff\xff\xdf\xdf\xdf\xdf\xdf\xdf\0\0\x1\x1\xff\xffMMMMMM\0\0\x1\x1\xff\xffSSSSSS\0\0\x1\x1\xff\xffGGGGGG\0\0\x1\x1\xff\xff((((((\0\0\x1\x1\xff\xff\x32\x32\x32\x32\x32\x32\0\0\x1\x1\xff\xff\xdf\xdf\xdf\xdf\xdf\xdf\0\0\x1\x1\xff\xff\xff\xff\xff\xff\xff\xff\0\0\x1\x1\xff\xff\xdf\xdf\xdf\xdf\xdf\xdf\0\0\x1\x1\xff\xff\xf\xf\xf\xf\xf\xf\0\0\x1\x1\xff\xff\xf\xf\xf\xf\xf\xf\0\0\x1\x1\xff\xff\0\0\0\0\0\0\0\0\x1\x2\xff\xff\xff\xff\0\0\xdf\xdf\0\0\x1\x1\xff\xff\x33\x33\x33\x33\x33\x33\0\0\x1\x1\xff\xff\0\0WW\xae\xae\0\0\x1\x1\xff\xff\xe0\xe0@@\xfb\xfb\0\0\x1\x1\xff\xff......\0\0)
            qt\plugindir=
            qt\stylesheetpath=
            qt\trpath=
            qt\widgetstyle=kvantum
          '';
        };
      };
    };

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
      
      # profileExtra = ''
      #   if [ -z "''${DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
      #     exec Hyprland
      #   fi
      # '';
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
      theme.package = pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; };
    };

    # Mako
    # services.mako = {
    #   enable = true;
    #   backgroundColor = "#0F0F0FFF";
    #   borderColor = "#E0E0E0FF";
    #   borderRadius = 10;
    #   borderSize = 2;
    #   defaultTimeout = 5000;
    #   font = "sans 12";
    #   progressColor = "over #E0E0E0FF";
    # };

    # Wofi
    programs.wofi = {
      enable = true;

      settings = {
        show = "drun";
        width = 512;
        height = 384;
        always_parse_args = true;
        show_all = true;
        print_command = true;
        prompt = "";
        layer = "overlay";
        insensitive = true;
        content_halign = "top";
        allow_images = true;
      };

      style = ''
        window {
          margin: 0px;
          border: 2px solid #e0e0e0;
          border-radius: 10px;
          background-color: #0f0f0f;
          font-size: 16px;
          font-weight: Bold;
        }

        #input {
          margin: 8px;
          border-radius: 8px;
          color: #ffffff;
          background-color: #181818;
        }

        #input image {
        	color: #303030;
        }

        #inner-box {
          margin: 0px 8px 0px 0px;
          border: none;
          padding-left: 8px;
          padding-right: 8px;
          border-radius: 8px;
          background-color: #0f0f0f;
        }

        #outer-box {
          margin: 8px;
          border: none;
          background-color: #0f0f0f;
          border-radius: 8px;
        }

        #scroll {
          margin: 0px;
          border: none;
        }

        #text {
          margin: 0px 8px 0px 8px;
          border: none;
          color: #ffffff;
        } 

        #entry:selected {
        	background-color: #e0e0e0;
        	font-weight: normal;
        	border-radius: 8px;
        }

        #text:selected {
        	background-color: #e0e0e0;
        	color: #000000;
        	font-weight: normal;
        }
      '';
    };

    # Swayosd
    services.swayosd = {
      enable = true;
      maxVolume = 100;
    };

    # Wlogout
    programs.wlogout = {
      enable = true;

      layout = [
        {
          label = "lock";
          action = "swaylock --screenshots --clock --indicator --effect-blur 8x8 --text-color ffffff --indicator-radius 200 --inside-color 00000000 --key-hl-color 00000000 --ring-color 00000000 --line-color 00000000 --separator-color 00000000 --text-ver-color ffffff --inside-ver-color 00000000 --ring-ver-color 00000000 --line-ver-color 00000000 --text-wrong-color cf4a4a --inside-wrong-color 00000000 --ring-wrong-color 00000000 --line-wrong-color 00000000 --text-clear-color 4acf4a --inside-clear-color 00000000 --ring-clear-color 00000000 --line-clear-color 00000000";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
        {
            label = "logout";
            action = "loginctl terminate-user $USER";
            text = "Logout";
            keybind = "e";
        }
        {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
        }
        {
            label = "suspend";
            action = "systemctl suspend";
            text = "Suspend";
            keybind = "u";
        }
        {
            label = "reboot";
            action = "systemctl reboot";
            text = "Reboot";
            keybind = "r";
        }
      ];
      
      style = ''
        window {
          background-color: rgba(0, 0, 0, 0.4);
        }
        
        button {
          font-size: 48px;
          color: #E0E0E0;
          background-color: #0F0F0F;
          border-style: solid;
          border-radius: 10px;
          border-width: 2px;
          margin: 4px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        button:focus, button:active, button:hover {
          font-size: 48px;
          color: #0F0F0F;
          background-color: #E0E0E0;
          outline-style: none;
        }
      '';
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
      extraOptions = [ "--gui-apikey=gezaa" ];
    };
    
    home.stateVersion = "23.05";
  };
}
