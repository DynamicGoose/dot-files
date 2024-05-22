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
  boot.kernelPackages = pkgs.linuxPackages_latest;
   
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

    pam.loginLimits = [
      {
        domain = "@audio";
        item = "rtprio";
        type = "hard";
        value = 95;
      }
      {
        domain = "@audio";
        item = "memlock";
        type = "hard";
        value = "unlimited";
      }
    ];
  };

  # User config
  users.defaultUserShell = pkgs.zsh;
  users.users = {
    gezaa = {
      isNormalUser = true;
      description = "Géza Ahsendorf";
      extraGroups = [ "networkmanager" "wheel" "audio" ];
    };
  };
  
  # Services
  services = {
    displayManager.sessionPackages = [ pkgs.hyprland ];
    xserver = {
      enable = true;
      
      displayManager = {
        lightdm = {
          enable = true;
          background = "${pkgs.budgie.budgie-backgrounds}/share/backgrounds/budgie/saturnian-profile.jpg";
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
  # electron apps should use Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  environment.systemPackages = with pkgs; [
    adwaita-qt6
    ani-cli
    bespokesynth
    blender
    brightnessctl
    btop
    cinnamon.nemo
    cliphist
    discord
    esbuild
    firefox-wayland
    gedit
    geogebra
    gimp
    git
    glibc
    gnome.cheese
    gnome.gnome-disk-utility
    grim
    hypridle
    hyprlock
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
    manga-cli
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
    qsyncthingtray
    rustup
    sbt
    signal-desktop
    simple-http-server
    slurp
    spotify
    swaybg
    swayidle
    swaynotificationcenter
    swayosd
    tidal-hifi
    vsce
    vscodium
    wdisplays
    wget
    wineWowPackages.waylandFull
    wl-clipboard
    wl-clip-persist
    xarchiver
    xwaylandvideobridge
    zapzap
    zoom-us
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
        "hyprlock" = {
          enable = true;
          target = "hypr/hyprlock.conf";
          text = ''
            general {
              disable_loading_bar = false
              hide_cursor = true
              grace = 0
              no_fade_in = false
            }
            background {
              monitor =
              path =      
              color = rgba(0, 0, 0, 0.4)

              blur_passes = 0
              blur_size = 7
              noise = 0.0117
              contrast = 0.8916
              brightness = 0.8172
              vibrancy = 0.1696
              vibrancy_darkness = 0.0
            }
            input-field {
              monitor =
              size = 200, 50
              outline_thickness = 2
              dots_size = 0.2
              dots_spacing = 0.3
              dots_center = true
              dots_rounding = -1
              outer_color = rgb(240, 240, 240)
              inner_color = rgb(24, 24, 24)
              font_color = rgb(255, 255, 255)
              fade_on_empty = true
              fade_timeout = 1000
              placeholder_text = <i>Password</i>
              hide_input = false
              rounding = 10
              check_color = rgb(50, 180, 50)
              fail_color = rgb(180, 50, 50)
              fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
              fail_transition = 300
              capslock_color = -1
              numlock_color = -1
              bothlock_color = -1
              invert_numlock = false
              position = 0, -20
              halign = center
              valign = center
            }
            label {
              monitor = 
              text = $TIME
              color = rgba(240, 240, 240, 1.0)
              font_size = 48
              font_family = Ubuntu Nerd Font Med
              position = 0, 64
              halign = center
              valign = center
            }
          '';
        };
        "hypridle" = {
          enable = true;
          target = "hypr/hypridle.conf";
          text = ''
            general {
              lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
              before_sleep_cmd = loginctl lock-session    # lock before suspend.
              after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
          }

          listener {
              timeout = 150                                # 2.5min.
              on-timeout = brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
              on-resume = brightnessctl -r                 # monitor backlight restor.
          }

          # turn off keyboard backlight, uncomment this section if have keyboard backlight.
          listener { 
              timeout = 150                                          # 2.5min.
              on-timeout = brightnessctl -sd rgb:kbd_backlight set 0 # turn off keyboard backlight.
              on-resume = brightnessctl -rd rgb:kbd_backlight        # turn on keyboard backlight.
          }

          listener {
              timeout = 300                                 # 5min
              on-timeout = loginctl lock-session            # lock screen when timeout has passed
          }

          listener {
              timeout = 380                                 # 5.5min
              on-timeout = hyprctl dispatch dpms off        # screen off when timeout has passed
              on-resume = hyprctl dispatch dpms on          # screen on when activity is detected after timeout has fired.
          }

          listener {
              timeout = 1800                                # 30min
              on-timeout = systemctl suspend                # suspend pc
          }
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

    # Wlogout
    programs.wlogout = {
      enable = true;

      layout = [
        {
          label = "lock";
          action = "hyprlock";
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
