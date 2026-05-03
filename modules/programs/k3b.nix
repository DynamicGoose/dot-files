{
  programs.k3b.enable = true;
  services.udev.extraRules = ''
    # Optical Drive access for K3b
    KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"
  '';
}
