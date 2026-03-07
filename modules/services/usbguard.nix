{
  config,
  lib,
  username,
  ...
}:
{
  options.modules.security.usbguard.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable usbguard to protect usb ports.";
  };

  config.services.usbguard = lib.mkIf config.modules.security.usbguard.enable {
    enable = true;
    IPCAllowedUsers = [
      "root"
      username
    ];
    presentDevicePolicy = "allow";
    rules = ''
      # allow `only` devices with mass storage interfaces (USB Mass Storage)
      allow with-interface equals { 08:*:* }
      # allow mice and keyboards
      allow with-interface equals { 03:*:* }

      # Reject devices with suspicious combination of interfaces
      reject with-interface all-of { 08:*:* 03:00:* }
      reject with-interface all-of { 08:*:* 03:01:* }
      reject with-interface all-of { 08:*:* e0:*:* }
      reject with-interface all-of { 08:*:* 02:*:* }
    '';
  };
}
