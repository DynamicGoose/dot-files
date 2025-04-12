{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = [ pkgs.wofi-power-menu ];

  home-manager.users.${username} =
    { config, ... }:
    {
      xdg.configFile."wofi-power-menu.toml".text = ''
        [menu.shutdown]
          cmd = "systemctl poweroff"
          requires_confirmation = "false"

        [menu.reboot]
          cmd = "systemctl reboot"
          requires_confirmation = "false"

        [menu.suspend]
          cmd = "systemctl suspend"
          requires_confirmation = "false"

        [menu.hibernate]
          cmd = "systemctl hibernate"
          requires_confirmation = "false"

        [menu.logout]
          cmd = "niri msg action quit -s"
          requires_confirmation = "false"

        [menu.lock-screen]
          cmd = "loginctl lock-session"
          requires_confirmation = "false"
      '';
    };
}
