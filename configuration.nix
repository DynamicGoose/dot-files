{ inputs, config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  
  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  # Networking
  networking = {
    hostName = "tp-e490";
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
    
    fonts = with pkgs; [
      jetbrains-mono
      nerdfonts
    ];
  };

  # Sound
  sound.enable = true;

  # Hardware
  hardware = {
    pulseaudio.enable = false;
  };

  # Security
  security = {
    rtkit.enable = true;

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
      displayManager.startx.enable = true;
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

    blueman.enable = true;
    printing.enable = true;
    cpupower-gui.enable = true;
  };

  # NixPkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  # Environment
  environment.shells = with pkgs; [ zsh bash ];
  environment.systemPackages = with pkgs; [
    btop
    cinnamon.nemo
    esbuild
    firefox-wayland
    gimp
    git
    grim
    hyprpicker
    killall
    kitty
    krita
    libreoffice
    mako
    neofetch
    networkmanagerapplet
    nodePackages.typescript
    nodejs_20
    pavucontrol
    polkit_gnome
    sbt
    signal-desktop
    slurp
    spotify
    swaybg
    swaylock-effects
    vsce
    vscodium
    waybar
    wdisplays
    wget
    whatsapp-for-linux
    wl-clipboard
    zulu
  ];

  # Programs
  programs = {
    dconf.enable = true;
    zsh.enable = true;
  };

  # System
  system = {
    autoUpgrade.enable = true;
    stateVersion = "23.05";
  };

  # Home-Manager
  home-manager.useGlobalPkgs = true;
  home-manager.users.gezaa = { pkgs, ... }: let
    flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

    hyprland = (import flake-compat {
      src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
    }).defaultNix;
  in {
    imports = [
      hyprland.homeManagerModules.default
    ];

    # Hyprland
    wayland.windowManager.hyprland = {
      enable = true;

      extraConfig = ''
          monitor=,preferred,auto,1

          exec-once = waybar
          exec-once = swaybg -m fill -i ~/.config/wallpaper/wallpaper.jpg -o eDP-1
          exec-once = nm-applet
          exec-once = blueman-applet

          # Source a file (multi-file configs)
          # source = ~/.config/hypr/myColors.conf

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
          blur = true
          blur_ignore_opacity = false
          blur_size = 8
          blur_passes = 1
          blur_new_optimizations = on

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
          }

          # Binds
          bind = , Print, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%s_grim.png') | wl-copy
          bind = CTRL_ALT, C, exec, hyprpicker --autocopy
          bind = ALT, X, killactive,  
          bind = ALT, F, togglefloating, 
          bind = CTRL_ALT, T, exec, kitty
          bind = SUPER, A, exec, wofi
          bind = SUPER_ALT, L, exec, swaylock --screenshots --clock --indicator --effect-blur 8x8 --text-color ffffff --indicator-radius 200 --inside-color 00000000 --key-hl-color 00000000 --ring-color 00000000 --line-color 00000000 --separator-color 00000000 --text-ver-color ffffff --inside-ver-color 00000000 --ring-ver-color 00000000 --line-ver-color 00000000 --text-wrong-color cf4a4a --inside-wrong-color 00000000 --ring-wrong-color 00000000 --line-wrong-color 00000000 --text-clear-color 4acf4a --inside-clear-color 00000000 --ring-clear-color 00000000 --line-clear-color 00000000
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
        export PS1="[%m::%n::%1d]: "
      '';
      
      profileExtra = ''
        if [ -z "''${DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
          exec Hyprland
        fi
      '';
    };

    # GTK
    gtk = {
      enable = true;
      iconTheme.name = "Papirus-Dark";
      iconTheme.package = pkgs.papirus-icon-theme;
      theme.name = "Graphite-Dark";
      theme.package = pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; };
    };

    # Waybar
    programs.waybar = {
      enable = true;
      settings = [
        {
          "spacing" =  4;
          "layer" = "top";
          "position" = "top";
          "margin-top" = 6;
          "margin-bottom" = 0;
          "margin-left" = 6;
          "margin-right" = 6;
          "height" = 34;
          "modules-left" = [ "clock" "wlr/workspaces" ];
          "modules-center" = [ "hyprland/window" ];
          "modules-right" = [ "tray" "pulseaudio" "backlight" "battery" "custom/power" ];

          "wlr/workspaces" = {
            "on-click" = "activate";
            "all-outputs" = true;
            "active-only" = false;
          };

          "backlight" = {
            "format" = "{icon} {percent}%";
            "format-icons" = [ "󰃞" "󰃟" "󰃠" ];
            "on-click" = "wdisplays";
          };

          "battery" = {
            "format" = "{icon} {capacity}%";
            "format-icons" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            "on-click" = "cpupower-gui";
          };

          "clock" = {
            "format" = "󱑇 {:%H:%M}";
          };

          "pulseaudio" = {
            "format" = "{icon} {volume}%";
            "format-bluetooth" = "{icon}󰂯 {volume}%";
            "format-muted" = "";
            "format-icons" = {
              "headphones" = "󰋋";
              "phone" = "";
              "default" = ["" ""];
            };
            "on-click" = "pavucontrol";
          };

          "tray" = {
            "spacing" = 4;
            "reverse-direction" = true;
          };

          "custom/power" = {
            "format" = "⏻";
            "on-click" = "wlogout";
          };
        }
      ];
      
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
      };
    };
    
    home.stateVersion = "23.05";
  };
}