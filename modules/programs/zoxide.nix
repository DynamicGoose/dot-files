{
  username,
  ...
}:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      programs.zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };

      programs.nushell.shellAliases.cd = "z";
    };
}
