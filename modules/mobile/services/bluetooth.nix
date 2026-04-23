{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mobile.quirks.qualcomm;
  inherit (lib) mkIf mkOption types;
in
{
  options.mobile = {
    quirks.qualcomm.qca-bluetooth.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable this on a device which uses the hci_uart_qca driver and needs a
        random mac address set in order to allow bluetooth functionality to work
        correctly
      '';
    };
  };

  config = mkIf (cfg.qca-bluetooth.enable) {
    systemd.services.qca-bluetooth =
      let
        script = pkgs.writeShellScript "qca-bluetooth.sh" ''
          set -x
          trap 'sleep 1' DEBUG # Sleep 1 second before every command execution
          export PATH="${
            lib.makeBinPath (
              with pkgs;
              [
                bluez
                coreutils-full
                gawk
                unixtools.script
              ]
            )
          }:$PATH"

          SERIAL=$(grep -o "serialno.*" /proc/cmdline | cut -d" " -f1)
          BT_MAC=$(echo "$SERIAL-BT" | sha256sum | awk -v prefix=0200 '{printf("%s%010s\n", prefix, $1)}')
          BT_MAC=$(echo "$BT_MAC" | cut -c1-12 | sed 's/\(..\)/\1:/g' | sed '$s/:$//')

          script -qc "btmgmt --timeout 3 -i hci0 power off"
          script -qc "btmgmt --timeout 3 -i hci0 public-addr \"$BT_MAC\""
        '';
      in
      {
        description = "Setup the bluetooth interface";
        wantedBy = [
          "multi-user.target"
          "bluetooth.service"
        ];
        script = toString script;
        serviceConfig = {
          User = "root";
          Type = "oneshot";
          RemainAfterExit = true;
        };
      };
  };
}
