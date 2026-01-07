{
  hardware.keyboard.qmk.enable = true;
  services.udev.extraRules = ''
    # Epomaker Galaxy100 Lite
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36b0", ATTRS{idProduct}=="3055", MODE="0666", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
}
