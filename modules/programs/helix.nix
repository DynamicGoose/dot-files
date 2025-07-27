{
  config,
  username,
  ...
}:
{
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
  
  home-manager.users.${username} =
    { config, ... }:
    {
      programs.helix = {
        enable = true;
        defaultEditor = true;
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
        languages = {
          language = [
            {
              name = "nix";
              formatter = {
                command = "nixfmt";
              };
              auto-format = true;
            }
          ];

          grammar = [
            {
              name = "nu";
              source = {
                git = "https://github.com/nushell/tree-sitter-nu";
                rev = "6544c4383643cf8608d50def2247a7af8314e148";
              };
            }
          ];
        };
      };
    };
}
