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

    networkmanager.enable = true;
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
    ];
  };

  # Sound
  sound.enable = true;

  # Hardware
  hardware = {
    bluetooth.enable = true;
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
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # NixPkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
      ardour = super.ardour.overrideAttrs (oldAttrs: {
        version = "7.5";
      });
    })
  ];

  # Environment
  environment.shells = with pkgs; [ zsh bash ];
  environment.systemPackages = with pkgs; [
    ardour
    brightnessctl
    btop
    cinnamon.nemo
    discord
    esbuild
    firefox-wayland
    galculator
    gedit
    geogebra6
    gimp
    git
    gnome.gnome-disk-utility
    grim
    hyprpicker
    imv
    killall
    kitty
    krita
    libreoffice
    lutris
    mako
    mpv
    musescore
    neofetch
    networkmanagerapplet
    nodePackages.typescript
    nodejs_20
    obsidian
    pavucontrol
    prismlauncher
    protonup-qt
    sbt
    signal-desktop
    simple-http-server
    slurp
    spotify
    swaybg
    swayidle
    swaylock-effects
    syncthing-tray
    vsce
    vscodium
    wdisplays
    wget
    whatsapp-for-linux
    wineWowPackages.waylandFull
    wl-clipboard
    wl-clip-persist
    xarchiver
    zulu
  ];

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
    stateVersion = "23.05";
  };

  # Home-Manager
  home-manager.useGlobalPkgs = true;
  home-manager.users.gezaa = { pkgs, ... }: {
    # Hyprland
    wayland.windowManager.hyprland = {
      enable = true;

      extraConfig = ''
        monitor=,preferred,auto,1

        exec-once = wl-clip-persist --clipboard both
        exec-once = swayidle -w timeout 120 'brightnessctl -s && brightnessctl s 5%' resume 'brightnessctl -r' timeout 240 'hyprctl dispatch dpms off' timeout 3600 'hyprctl dispatch dpms on && systemctl suspend' before-sleep 'swaylock --screenshots --clock --indicator --effect-blur 8x8 --text-color ffffff --indicator-radius 200 --inside-color 00000000 --key-hl-color 00000000 --ring-color 00000000 --line-color 00000000 --separator-color 00000000 --text-ver-color ffffff --inside-ver-color 00000000 --ring-ver-color 00000000 --line-ver-color 00000000 --text-wrong-color cf4a4a --inside-wrong-color 00000000 --ring-wrong-color 00000000 --line-wrong-color 00000000 --text-clear-color 4acf4a --inside-clear-color 00000000 --ring-clear-color 00000000 --line-clear-color 00000000'
        exec-once = waybar
        exec-once = swaybg -m fill -i ${pkgs.budgie.budgie-backgrounds}/share/backgrounds/budgie/apollo-11-earth.jpg -o eDP-1
        exec-once = nm-applet
        exec-once = sleep 1 && blueman-applet
        exec-once = sleep 3 && syncthing-tray -api gezaa
        exec-once = id=0

        input {
          kb_layout = de
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
          scroll_method = 2fg
          follow_mouse = 1
          numlock_by_default = true

          touchpad {
            natural_scroll = true
            disable_while_typing = false
            tap-to-click = true
          }

          sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.
        }

        general {
          gaps_in = 3px
          gaps_out = 6px
          border_size = 2
          resize_on_border = false
          col.active_border = rgba(e0e0e0ff)
          col.inactive_border = rgba(00000000)
          layout = master
        }

        decoration {
          active_opacity = 1.0
          inactive_opacity = 1.0
          fullscreen_opacity = 1.0
          rounding = 8

          blur {
            enabled = true
            size = 8
            passes = 1
            ignore_opacity = false
            new_optimizations = true
          }

          drop_shadow = false
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
        }

        animations {
          enabled = yes

          bezier = overshot, 0.05, 0.9, 0.1, 1.05
          bezier = fade, 0, 0, 0, 1

          animation = windows, 1, 7, overshot
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = fade, 1, 7, fade
          animation = workspaces, 1, 6, default
        }

        master {
          new_is_master = true
        }

        gestures {
          workspace_swipe = true
        }

        misc {
          disable_hyprland_logo = true
          vfr = true
          enable_swallow = true
          swallow_regex = ^(kitty)$
          mouse_move_enables_dpms = true
          key_press_enables_dpms = true
        }

        # Window Rules
        windowrule = float, title:^(Bluetooth Devices)
        windowrule = float, title:^(Network Connections)
        windowrule = float, title:^(Volume Control)
        windowrule = float, title:(wdisplays)
        windowrule = float, title:(cpupower-gui)
        windowrule = float, galculator
        
        windowrule = center (1), title:^(Bluetooth Devices)
        windowrule = center (1), title:^(Network Connections)
        windowrule = center (1), title:^(Volume Control)
        windowrule = center (1), title:(wdisplays)
        windowrule = center (1), title:(cpupower-gui)
        windowrule = center (1), galculator
        
        windowrule = size 60% 60%, title:^(Bluetooth Devices)
        windowrule = size 60% 60%, title:^(Network Connections)
        windowrule = size 60% 60%, title:^(Volume Control)
        windowrule = size 60% 60%, title:(wdisplays)
        windowrule = size 60% 60%, title:(cpupower-gui)

        # Binds
        bind = , Print, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%s_grim.png') && wl-copy < ~/Pictures/Screenshots/$(date +'%s_grim.png')
        bind = CTRL_ALT, C, exec, hyprpicker --autocopy
        bind = SUPER, C, exec, galculator
        bind = ALT, X, killactive,  
        bind = ALT, F, togglefloating, 
        bind = SUPER, F, fullscreen,
        bind = CTRL_ALT, T, exec, kitty
        bind = SUPER, A, exec, wofi
        bind = SUPER_ALT, L, exec, swaylock --screenshots --clock --indicator --effect-blur 8x8 --text-color ffffff --indicator-radius 200 --inside-color 00000000 --key-hl-color 00000000 --ring-color 00000000 --line-color 00000000 --separator-color 00000000 --text-ver-color ffffff --inside-ver-color 00000000 --ring-ver-color 00000000 --line-ver-color 00000000 --text-wrong-color cf4a4a --inside-wrong-color 00000000 --ring-wrong-color 00000000 --line-wrong-color 00000000 --text-clear-color 4acf4a --inside-clear-color 00000000 --ring-clear-color 00000000 --line-clear-color 00000000
        bind = SUPER_ALT, P, exec, wlogout
        bind = ALT, comma, splitratio, -0.05
        bind = ALT, period, splitratio, +0.05

        # Move focus with alt + arrow keys
        bind = ALT, left, movefocus, l
        bind = ALT, right, movefocus, r
        bind = ALT, up, movefocus, u
        bind = ALT, down, movefocus, d
        bind = ALT_CTRL, left, movewindow, l
        bind = ALT_CTRL, right, movewindow, r
        bind = ALT_CTRL, up, movewindow, u
        bind = ALT_CTRL, down, movewindow, d

        # Switch workspaces with alt + [0-9]
        bind = ALT, 1, workspace, 1
        bind = ALT, 2, workspace, 2
        bind = ALT, 3, workspace, 3
        bind = ALT, 4, workspace, 4
        bind = ALT, 5, workspace, 5
        bind = ALT, 6, workspace, 6
        bind = ALT, 7, workspace, 7
        bind = ALT, 8, workspace, 8
        bind = ALT, 9, workspace, 9
        bind = ALT, 0, workspace, 10
        bind = ALT_SUPER, left, workspace, e-1
        bind = ALT_SUPER, right, workspace, e+1

        # Move active window to a workspace with ALT + CTRL + [0-9]
        bind = ALT_CTRL, 1, movetoworkspace, 1
        bind = ALT_CTRL, 2, movetoworkspace, 2
        bind = ALT_CTRL, 3, movetoworkspace, 3
        bind = ALT_CTRL, 4, movetoworkspace, 4
        bind = ALT_CTRL, 5, movetoworkspace, 5
        bind = ALT_CTRL, 6, movetoworkspace, 6
        bind = ALT_CTRL, 7, movetoworkspace, 7
        bind = ALT_CTRL, 8, movetoworkspace, 8
        bind = ALT_CTRL, 9, movetoworkspace, 9
        bind = ALT_CTRL, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
        bind = ALT, mouse_down, workspace, e+1
        bind = ALT, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = ALT, mouse:272, movewindow
        bindm = ALT, mouse:273, resizewindow

        # Funtion keys
        binde = , XF86AudioRaiseVolume, exec, swayosd --output-volume=raise
        binde = , XF86AudioLowerVolume, exec, swayosd --output-volume=lower
        bind = , XF86AudioMute, exec, swayosd --output-volume=mute-toggle
        binde = , XF86MonBrightnessUp, exec, brightnessctl s 5%+
        # swayosd --brightness=raise
        binde = , XF86MonBrightnessDown, exec, brightnessctl s 5%-
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
    services.mako = {
      enable = true;
      backgroundColor = "#0F0F0FFF";
      borderColor = "#E0E0E0FF";
      borderRadius = 10;
      borderSize = 2;
      defaultTimeout = 5000;
      font = "sans 12";
      progressColor = "over #E0E0E0FF";
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