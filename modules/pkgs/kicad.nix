{
  config,
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = [ pkgs.kicad ];

  home-manager.users.${username} =
    { config, ... }:
    {
      xdg.desktopEntries = {
        kicad = {
          name = "org.kicad.kicad";
          settings = {
            Version = "1.0";
            Terminal = "false";
            Icon = "kicad";
            Type = "Application";
            Categories = "Science;Electronics;";
            Exec = "GTK_THEME=Adwaita:dark kicad %f";
            StartupWMClass = "kicad";
            Keywords = "Projectmanager";
            MimeType = "application/x-kicad-project";
            Name = "KiCad";
            GenericName = "EDA Suite";
            Comment = "Suite of tools for schematic design and circuit board layout";
            X-Desktop-File-Install-Version = "0.22";
          };
        };
      };
    };
}
