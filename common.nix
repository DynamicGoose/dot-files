{
  inputs,
  config,
  pkgs,
  ...
}: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  # Bootloader configured by host

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    # Silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # Networking
  networking = {
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
      dejavu_fonts
      nerd-fonts.ubuntu
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      comic-mono
    ];
  };

  # Hardware
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Security
  security = {
    rtkit.enable = true;
    polkit.enable = true;

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
    xserver = {
      enable = true;

      displayManager = {
        lightdm = {
          enable = true;
          background = "${pkgs.graphite-gtk-theme.override {wallpapers = true;}}/share/backgrounds/wave-Dark.png";
          greeters.gtk = {
            enable = true;
            theme.package = pkgs.graphite-gtk-theme.override {tweaks = ["black"];};
            theme.name = "Graphite-Dark";
            iconTheme.package = pkgs.papirus-icon-theme;
            iconTheme.name = "Papirus-Dark";
            cursorTheme.package = pkgs.graphite-cursors;
            cursorTheme.name = "graphite-dark";
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
      jack.enable = true;
    };

    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    openssh = {
      enable = true;
      # Only run when needed, bc this is not a server
      startWhenNeeded = true;
      openFirewall = true;      
    };
    
    # Printing
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint ];
    };

    # Printer autodiscovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    blueman.enable = true;
    fail2ban.enable = true;
    gnome.gnome-keyring.enable = true;
    gpm.enable = true;
    gvfs.enable = true;
    pulseaudio.enable = false;
  };

  # Systemd
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    user.extraConfig = "DefaultLimitNOFILE=524288";
    extraConfig = "DefaultLimitNOFILE=524288";
  };

  # XDG
  xdg.portal = {
    enable = true;
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # QT
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  # NixPkgs
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
    overlays = [ ];
  };

  # Environment
  environment.shells = with pkgs; [zsh bash];
  # electron apps should use Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xkb";
    QT_STYLE_OVERRIDE = "kvantum";
  };
  environment.systemPackages = with pkgs; [
    ani-cli
    audacity
    binsider
    brightnessctl
    btop
    cheese
    cliphist
    discord-canary
    fastfetch
    firefox-wayland
    gamemode
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
    hypridle
    hyprlock
    hyprpicker
    hyprshot
    imv
    killall
    kitty
    kooha
    krita
    libgcc
    libreoffice
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    lutris
    manga-cli
    mission-center
    mpv
    musescore
    networkmanagerapplet
    nemo-with-extensions
    obsidian
    playerctl
    prismlauncher
    protonup-qt
    pwvucontrol
    python3
    qalculate-gtk
    r2modman
    rustup
    sidequest
    signal-desktop
    spotify
    stc-cli
    swaybg
    swaynotificationcenter
    swayosd
    syncthingtray
    tealdeer
    telegram-desktop
    thunderbird
    # vesktop
    vscodium
    wdisplays
    wget
    wineWowPackages.waylandFull
    wl-clipboard
    wl-clip-persist
    xarchiver
    yabridge
    yabridgectl
    zapzap
    zed-editor.fhs
    zoom-us
    zrythm
    zulu
    zulu17
  ];

  # Virtualisation
  virtualisation.libvirtd.enable = true;

  # Programs
  programs = {
    alvr = {
      enable = true;
      openFirewall = true;
    };
    
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    dconf.enable = true;
    evince.enable = true;
    hyprland.enable = true;
    ssh.askPassword = "";
    virt-manager.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
  };

  # System
  system = {
    stateVersion = "25.05";
  };

  # Home-Manager
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.gezaa = {pkgs, ...}: {
    # XDG
    xdg = {
      enable = true;
      configFile = {
        # kvantum theme
        "Kvantum/Graphite/GraphiteDark.kvconfig".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite/GraphiteDark.kvconfig";
        "Kvantum/Graphite/GraphiteDark.svg".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite/GraphiteDark.svg";
        "Kvantum/Graphite/Graphite.kvconfig".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite/Graphite.kvconfig";
        "Kvantum/Graphite/Graphite.svg".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite/Graphite.svg";
        "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=GraphiteDark";

        # Swaync style
        "swaync/style.css".text = ''
          @define-color cc-bg rgba(15, 15, 15, 1);
          @define-color noti-border-color rgba(224, 224, 224, 1);
          @define-color noti-bg rgb(15, 15, 15);
          @define-color noti-bg-darker rgb(15, 15, 15);
          @define-color noti-bg-hover rgb(34, 34, 34);
          @define-color noti-bg-focus rgba(56, 56, 56, 1);
          @define-color noti-close-bg rgba(56, 56, 56, 1);
          @define-color noti-close-bg-hover rgba(75, 75, 75, 1);
          @define-color text-color rgba(255, 255, 255, 1);
          @define-color text-color-disabled rgb(150, 150, 150);
          @define-color bg-selected rgb(224, 224, 224);

          .control-center .notification-row:focus,
          .control-center .notification-row:hover {
            opacity: 1;
            background: @noti-bg-darker
          }

          .notification-row {
            outline: none;
          }

          .notification {
            border-radius: 10px;
            margin: 6px 0px 0px 0px;
            padding: 0;
            border: 2px solid @noti-border-color
          }

          .notification-content {
            background: transparent;
            padding: 8px;
            border-radius: 10px
          }

          .close-button {
            background: @noti-close-bg;
            color: @text-color;
            text-shadow: none;
            padding: 0;
            border-radius: 100%;
            margin-top: 10px;
            margin-right: 10px;
            box-shadow: none;
            border: none;
            min-width: 24px;
            min-height: 24px
          }

          .close-button:hover {
            box-shadow: none;
            background: @noti-close-bg-hover;
            transition: all .15s ease-in-out;
            border: none
          }

          .notification-default-action,
          .notification-action {
            padding: 4px;
            margin: 0;
            box-shadow: none;
            background: @noti-bg;
            border: none;
            color: @text-color;
            transition: all .15s ease-in-out
          }

          .notification-default-action:hover,
          .notification-action:hover {
            -gtk-icon-effect: none;
            background: @noti-bg-hover
          }

          .notification-default-action {
            border-radius: 10px
          }

          .notification-default-action:not(:only-child) {
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0
          }

          .notification-action {
            border-radius: 0;
            border-top: none;
            border-right: none
          }

          .notification-action:first-child {
            border-bottom-left-radius: 6px;
            background: #1b1b2b
          }

          .notification-action:last-child {
            border-bottom-right-radius: 6px;
            background: #1b1b2b
          }

          .inline-reply {
            margin-top: 8px
          }

          .inline-reply-entry {
            background: @noti-bg-darker;
            color: @text-color;
            caret-color: @text-color;
            border: 2px solid @noti-border-color;
            border-radius: 10px
          }

          .inline-reply-button {
            margin-left: 4px;
            background: @noti-bg;
            border: 2px solid @noti-border-color;
            border-radius: 10px;
            color: @text-color
          }

          .inline-reply-button:disabled {
            background: initial;
            color: @text-color-disabled;
            border: 1px solid transparent
          }

          .inline-reply-button:hover {
            background: @noti-bg-hover
          }

          .body-image {
            margin-top: 6px;
            background-color: #fff;
            border-radius: 10px
          }

          .summary {
            font-size: 16px;
            font-weight: bold;
            background: transparent;
            color: @text-color;
            text-shadow: none
          }

          .time {
            font-size: 16px;
            font-weight: bold;
            background: transparent;
            color: @text-color;
            text-shadow: none;
            margin-right: 18px
          }

          .body {
            font-size: 15px;
            font-weight: 400;
            background: transparent;
            color: @text-color;
            text-shadow: none
          }

          .control-center {
            background: @cc-bg;
            border: 2px solid @noti-border-color;
            border-radius: 10px;
          }

          .control-center-list {
            background: transparent
          }

          .control-center-list-placeholder {
            opacity: .5
          }

          .floating-notifications {
            background: transparent
          }

          .blank-window {
            background: alpha(black, 0)
          }

          .widget-title {
            color: @text-color;
            margin: 8px;
            font-size: 1.5rem
          }

          .widget-title>button {
            font-size: initial;
            color: @text-color;
            text-shadow: none;
            background: @noti-bg;
            border: 2px solid @noti-border-color;
            box-shadow: none;
            border-radius: 10px
          }

          .widget-title>button:hover {
            background: @noti-bg-hover
          }

          .widget-dnd {
            color: @text-color;
            margin: 8px;
            font-size: 1.1rem
          }

          .widget-dnd>switch {
            font-size: initial;
            border-radius: 10px;
            background: @noti-bg;
            border: 2px solid @noti-border-color;
            box-shadow: none
          }

          .widget-dnd>switch:checked {
            background: @bg-selected
          }

          .widget-dnd>switch slider {
            background: @noti-bg-hover;
            border-radius: 10px
          }

          .widget-label {
            margin: 8px;
          }

          .widget-label>label {
            font-size: 1.5rem;
            color: @text-color;
          }

          .widget-mpris {
            color: @text-color;
            background: @noti-bg-darker;
            padding: 8px;
            margin: 0px;
          }

          .widget-mpris-player {
            padding: 8px;
            margin: 8px
          }

          .widget-mpris-title {
            font-weight: 700;
            font-size: 1.25rem
          }

          .widget-mpris-subtitle {
            font-size: 1.1rem
          }

          .widget-buttons-grid {
            font-size: x-large;
            padding: 8px;
            margin: 0px;
            background: @noti-bg-darker;
          }

          .widget-buttons-grid>flowbox>flowboxchild>button {
            margin: 8px;
            background: @noti-bg;
            border-radius: 10px;
            color: @text-color
          }

          .widget-buttons-grid>flowbox>flowboxchild>button:hover {
            background: @noti-bg-hover;
            color: @noti-border-color
          }

          .widget-menubar>box>.menu-button-bar>button {
            border: none;
            background: transparent
          }

          .topbar-buttons>button {
            border: none;
            background: transparent
          }

          .widget-volume {
            background: @noti-bg-darker;
            padding: 8px;
            margin: 0px;
            border-radius: 10px;
            font-size: x-large;
            color: @noti-border-color
          }

          .widget-volume>box>button {
            background: transparent;
            border: none
          }

          .per-app-volume {
            background-color: @noti-bg;
            padding: 4px 8px 8px;
            margin: 0 8px 8px;
            border-radius: 10px
          }

          .widget-backlight {
            background: @noti-bg-darker;
            padding: 8px;
            margin: 0px;
            border-radius: 0px;
            font-size: x-large;
            color: @noti-border-color
          }

          .widget-inhibitors {
            margin: 8px;
            font-size: 1.5rem
          }

          .widget-inhibitors>button {
            font-size: initial;
            color: @text-color;
            text-shadow: none;
            background: @noti-bg;
            border: 2px solid @noti-border-color;
            box-shadow: none;
            border-radius: 10px
          }

          .widget-inhibitors>button:hover {
            background: @noti-bg-hover
          }
        '';
      };
    };

    # Hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        # monitors configured by host
        
        exec-once = [
          "wl-clip-persist --clipboard regular"
          "cliphist wipe"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "waybar"
          "swayosd-server"
          "swaybg -m fill -i ${pkgs.graphite-gtk-theme.override {wallpapers = true;}}/share/backgrounds/wave-Dark.png -o eDP-1"
          "nm-applet"
          "swaync"
          "sleep 1 && blueman-applet"
          "sleep 3 && syncthingtray --wait"
          "id=0"
        ];

        general = {
          gaps_in = 3;
          gaps_out = 6;
          border_size = 2;
          resize_on_border = true;
          layout = "master";
          "col.active_border" = "rgba(e0e0e0ff)";
          "col.inactive_border" = "rgba(00000000)";
        };

        decoration = {
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          fullscreen_opacity = 1.0;
          rounding = 8;

          blur = {
            enabled = true;
            size = 8;
            passes = 1;
            ignore_opacity = false;
            new_optimizations = true;
          };

          shadow = {
            enabled = false;
          };
        };

        animations = {
          enabled = true;

          bezier = [
            "overshot, 0.05, 0.9, 0.1, 1.05"
            "fade, 0, 0, 0, 1"
          ];

          animation = [
            "windows, 1, 7, overshot"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, fade"
            "workspaces, 1, 6, default"
          ];
        };

        master = {
          new_status = "inherit";
        };

        input = {
          kb_layout = "de";
          scroll_method = "2fg";
          follow_mouse = 1;
          numlock_by_default = true;
          sensitivity = 0.5;

          touchpad = {
            natural_scroll = true;
            disable_while_typing = false;
            tap-to-click = true;
          };
        };

        gestures = {
          workspace_swipe = true;
        };

        misc = {
          disable_hyprland_logo = true;
          vfr = true;
          enable_swallow = true;
          swallow_regex = "^(kitty)$";
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        windowrule = [
          "float, .blueman-manager-wrapped"
          "float, nm-connection-editor"
          "float, com.saivert.pwvucontrol"
          "float, wdisplays"
          "float, cpupower-gui"
          "float, qalculate-gtk"
          "center (1), .blueman-manager-wrapped"
          "center (1), nm-connection-editor"
          "center (1), com.saivert.pwvucontrol"
          "center (1), wdisplays"
          "center (1), cpupower-gui"
          "center (1), qalculate-gtk"
          "size 60% 60%, .blueman-manager-wrapped"
          "size 60% 60%, nm-connection-editor"
          "size 60% 60%, com.saivert.pwvucontrol"
          "size 60% 60%, wdisplays"
          "size 60% 60%, cpupower-gui"
        ];

        windowrulev2 = [
          "opacity 0.0 override 0.0 override, class: ^(xwaylandvideobridge)$"
          "noanim, class:^(xwaylandvideobridge)$"
          "nofocus, class:^(xwaylandvideobridge)$"
          "noinitialfocus, class:^(xwaylandvideobridge)$"
          "float, title:(Steam Settings)"
          "float, title:(Syncthing Tray)"
          "center (1), title:(Syncthing Tray)"
          "size 60% 60%, title:(Syncthing Tray)"
        ];

        bind = [          
          ", Print, exec, hyprshot -o ~/Pictures/Screenshots -m region"
          "SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
          "CTRL_ALT, C, exec, hyprpicker --autocopy"
          "SUPER, C, exec, qalculate-gtk"
          "ALT, X, killactive,"
          "ALT, F, togglefloating,"
          "SUPER, F, fullscreen,"
          "CTRL_ALT, T, exec, kitty"
          "SUPER, A, exec, wofi"
          "SUPER_ALT, L, exec, hyprlock"
          "SUPER_ALT, P, exec, wlogout"
          "ALT, comma, splitratio, -0.05"
          "ALT, period, splitratio, +0.05"
          "ALT, left, movefocus, l"
          "ALT, right, movefocus, r"
          "ALT, up, movefocus, u"
          "ALT, down, movefocus, d"
          "ALT_CTRL, left, movewindow, l"
          "ALT_CTRL, right, movewindow, r"
          "ALT_CTRL, up, movewindow, u"
          "ALT_CTRL, down, movewindow, d"
          "ALT, 1, workspace, 1"
          "ALT, 2, workspace, 2"
          "ALT, 3, workspace, 3"
          "ALT, 4, workspace, 4"
          "ALT, 5, workspace, 5"
          "ALT, 6, workspace, 6"
          "ALT, 7, workspace, 7"
          "ALT, 8, workspace, 8"
          "ALT, 9, workspace, 9"
          "ALT, 0, workspace, 10"
          "ALT_SUPER, left, workspace, e-1"
          "ALT_SUPER, right, workspace, e+1"
          "ALT_CTRL, 1, movetoworkspace, 1"
          "ALT_CTRL, 2, movetoworkspace, 2"
          "ALT_CTRL, 3, movetoworkspace, 3"
          "ALT_CTRL, 4, movetoworkspace, 4"
          "ALT_CTRL, 5, movetoworkspace, 5"
          "ALT_CTRL, 6, movetoworkspace, 6"
          "ALT_CTRL, 7, movetoworkspace, 7"
          "ALT_CTRL, 8, movetoworkspace, 8"
          "ALT_CTRL, 9, movetoworkspace, 9"
          "ALT_CTRL, 0, movetoworkspace, 10"
          "ALT, mouse_down, workspace, e+1"
          "ALT, mouse_up, workspace, e-1"
          ", XF86AudioMute, exec, swayosd-client --output-volume=mute-toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
        ];

        binde = [
          ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume=raise"
          ", XF86AudioLowerVolume, exec, swayosd-client --output-volume=lower"
          ", XF86MonBrightnessUp, exec, swayosd-client --brightness=raise"
          ", XF86MonBrightnessDown, exec, swayosd-client --brightness=lower"
        ];

        bindm = [
          "ALT, mouse:272, movewindow"
          "ALT, mouse:273, resizewindow"
        ];

        bindr = [
          "SUPER, SUPER_L, exec, swaync-client -t"
        ];
      };
    };
    
    # Hyprlock
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          grace = 0;
          no_fade_in = false;
          ignore_empty_input = true;
        };

        auth = {
          fingerprint = {
            enabled = true;
          };
        };

        background = [
          {
            path = "screenshot";
            color = "rgba(0, 0, 0, 0.0)";
            blur_passes = 2;
            blur_size = 4;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -20";
            outline_thickness = 2;
            dots_size = 0.2;
            dots_spacing = 0.3;
            dots_center = true;
            dots_rounding = -1;
            outer_color = "rgb(240, 240, 240)";
            inner_color = "rgb(24, 24, 24)";
            font_color = "rgb(255, 255, 255)";
            fade_on_empty = true;
            fade_timeout = 1000;
            placeholder_text = "<i>Password</i>";
            hide_input = false;
            rounding = 10;
            check_color = "rgb(50, 180, 50)";
            fail_color = "rgb(180, 50, 50)";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            fail_transition = 300;
            capslock_color = -1;
            numlock_color = -1;
            bothlock_color = -1;
            invert_numlock = false;
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            text = "$TIME";
            color = "rgba(240, 240, 240, 1.0)";
            font_size = 48;
            font_family = "Ubuntu Nerd Font Med";
            position = "0, 64";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };

    # Hypridle
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
            on-resume = "brightnessctl -rd rgb:kbd_backlight";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 380;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    # Waybar
    programs.waybar = {
      enable = true;

      # settings configured by host
      
      style = ''
        * {
          font-size: 16px;
          font-family: "Ubuntu Nerdfont";
          font-weight: Bold;
          padding: 0 4px 0 4px;
        }
        window#waybar {
          background: #0F0F0F;
          color: #E0E0E0;
          border: Solid;
          border-radius: 10px;
          border-width: 2px;
          border-color: #E0E0E0;
        }
        #workspaces button {
          background: #0F0F0F;
          margin: 4px 2px 4px 2px;
        }
        #workspaces button.active {
          background: #E0E0E0;
          color: #0F0F0F;
          margin: 4px 2px 4px 2px;
        }
        #tray {
          padding: 0;
        }
      '';
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
      theme.package = pkgs.graphite-gtk-theme.override {tweaks = ["black"];};
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
          action = "hyprctl dispatch exit";
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

    # syncthing
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

    home.stateVersion = "25.05";
  };
}
