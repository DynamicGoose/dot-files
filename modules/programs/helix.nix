{
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
          theme = "minimal";

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
        themes.minimal =
          let
            black = "#000000";
            white = "#ffffff";
            grey = "#e0e0e0";
            dark-grey = "#a0a0a0";
            background-grey = "#0f0f0f";
            red = "#E00000";
            orange = "#ff8f40";
            yellow = "#cecd19";
            light-green = "#32d032";
            green = "#008030";
            blue = "#32c9fa";
            dark-blue = "#3060c0";
            purple = "#c040a0";
          in
          {
            # Interface
            "ui.background" = {
              bg = black;
            };
            "ui.cursor" = {
              bg = white;
              fg = black;
            };
            "ui.cursor.select" = {
              bg = dark-grey;
              fg = grey;
            };
            "ui.cursor.match" = {
              bg = white;
              fg = black;
            };
            "ui.cursor.secondary" = grey;
            "ui.linenr" = {
              fg = grey;
              bg = black;
            };
            "ui.linenr.selected" = {
              fg = dark-grey;
              bg = black;
            };
            "ui.statusline" = {
              fg = grey;
              bg = background-grey;
            };
            "ui.statusline.normal" = {
              fg = black;
              bg = blue;
            };
            "ui.statusline.insert" = {
              fg = black;
              bg = orange;
            };
            "ui.statusline.select" = {
              fg = black;
              bg = purple;
            };
            "ui.popup" = {
              fg = grey;
              bg = background-grey;
            };
            "ui.window" = {
              fg = grey;
            };
            "ui.help" = {
              fg = grey;
              bg = background-grey;
            };
            "ui.text" = {
              fg = grey;
            };
            "ui.text.focus" = {
              fg = black;
              bg = grey;
            };
            "ui.virtual.ruler" = {
              fg = grey;
              bg = dark-grey;
            };
            "ui.virtual.whitespace" = {
              fg = grey;
            };
            "ui.virtual.indent-guide" = {
              fg = dark-grey;
            };
            "ui.virtual.inlay-hint" = {
              fg = black;
              bg = orange;
            };
            "ui.virtual.wrap" = {
              fg = dark-grey;
            };
            "ui.menu" = {
              fg = grey;
              bg = background-grey;
            };
            "ui.menu.selected" = {
              fg = black;
              bg = grey;
            };
            "ui.menu.scroll" = {
              fg = grey;
              bg = dark-grey;
            };
            "ui.selection" = {
              fg = black;
              bg = grey;
            };
            "ui.selection.primary" = {
              fg = black;
              bg = grey;
            };
            "warning" = {
              fg = orange;
            };
            "error" = {
              fg = red;
              modifiers = [ "bold" ];
            };
            "info" = {
              fg = grey;
            };
            "hint" = {
              fg = white;
              modifiers = [ "bold" ];
            };
            "diagnostic" = {
              fg = grey;
            };
            "diagnostic.hint" = {
              underline = {
                color = white;
                style = "dashed";
              };
            };
            "diagnostic.info" = {
              underline = {
                color = white;
                style = "dotted";
              };
            };
            "diagnostic.warning" = {
              underline = {
                color = orange;
                style = "curl";
              };
            };
            "diagnostic.error" = {
              underline = {
                color = red;
                style = "curl";
              };
            };
            "diagnostic.unnecessary" = {
              modifiers = [ "dim" ];
            };
            "diagnostic.deprecated" = {
              modifiers = [ "crossed_out" ];
            };

            # Syntax Highlighting
            "attribute" = purple;
            "type" = blue;
            "constructor" = yellow;
            "constant" = yellow;
            "constant.numeric" = green;
            "string" = green;
            "comment" = light-green;
            "variable" = grey;
            "variable.parameter" = yellow;
            "variable.builtin" = yellow;
            "label" = grey;
            "punctuation" = dark-grey;
            "keyword" = dark-blue;
            "keyword.control" = purple;
            "operator" = grey;
            "function" = {
              fg = white;
              modifiers = [ "bold" ];
            };
            "tag" = dark-blue;
            "namespace" = grey;
            "special" = {
              fg = white;
              modifiers = [ "bold" ];
            };
            "markup" = grey;
            "markup.heading" = {
              fg = white;
              modifiers = [ "bold" ];
              underline = {
                color = white;
                style = "double_line";
              };
            };
            "markup.bold" = {
              fg = grey;
              modifiers = [ "bold" ];
            };
            "markup.italic" = {
              fg = grey;
              modifiers = [ "italic" ];
            };
            "markup.strikethrough" = {
              fg = grey;
              modifiers = [ "crossed_out" ];
            };
            "markup.link" = {
              fg = blue;
              underline = {
                color = "blue";
                style = "line";
              };
            };
            "markup.quote" = {
              fg = dark-grey;
              modifiers = [ "italic" ];
            };
            "diff.plus" = green;
            "diff.delta" = blue;
            "diff.minus" = red;
          };
      };
    };
}
