{ config, lib, inputs, username, ... }: {
  environment.persistence."/nix/persistent" = {
    enable = true;
    hieMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    users.${username} = {
      directories = [
        ".cache/cliphist"
        ".cache/mozilla"
        ".cache/tealdear"
        ".cache/thunderbird"
        
        ".config/discordcanary"
        ".config/gedit"
        ".config/nemo"
        ".config/obsidian"
        ".config/Signal"
        ".config/spotify"
        ".config/Valve"
        ".config/ZapZap"

        ".local/share"
        ".local/state/syncthing"
        ".local/state/wireplumber"
        
        ".games"
        ".gnupg"
        ".heroic"
        ".mozilla"
        ".ssh"
        ".steam"
        ".stfolder"
        ".var"
        ".vst"
        ".vst3"
        ".wine"
        ".zoom"
        
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "obsidian"
        "Pictures"
        "Public"
        "Videos"
        ""
      ];
      files = [
        ".config/mimeapps.list"
        ".config/syncthingtray.ini"
        ".config/user-dirs.dirs"
        ".config/user-dirs.locale"
        ".stignore"
        "syncthing.ini"
        ".zsh_history"
      ];
    };
  };
}
