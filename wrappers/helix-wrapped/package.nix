{ wrapper-modules, pkgs }:
wrapper-modules.wrappers.helix.wrap {
  inherit pkgs;
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
      background = "#0f0f0f";
      foreground-dark = "#616161";
      foreground = "#9E9E9E";
      accent = "#e0e0e0";
      purple = "#BA68C8";
      red = "#F44336";
      yellow = "#FFD600";
      green = "#66BB6A";
      blue = "#42A5F5";
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
        bg = foreground;
        fg = accent;
      };
      "ui.cursor.match" = {
        bg = white;
        fg = black;
      };
      "ui.cursor.secondary" = accent;
      "ui.linenr" = {
        fg = accent;
        bg = black;
      };
      "ui.linenr.selected" = {
        fg = foreground;
        bg = black;
      };
      "ui.statusline" = {
        fg = accent;
        bg = background;
      };
      "ui.statusline.normal" = {
        fg = black;
        bg = blue;
      };
      "ui.statusline.insert" = {
        fg = black;
        bg = yellow;
      };
      "ui.statusline.select" = {
        fg = black;
        bg = purple;
      };
      "ui.popup" = {
        fg = accent;
        bg = background;
      };
      "ui.window" = {
        fg = accent;
      };
      "ui.help" = {
        fg = accent;
        bg = background;
      };
      "ui.text" = {
        fg = accent;
      };
      "ui.text.focus" = {
        fg = black;
        bg = accent;
      };
      "ui.virtual.ruler" = {
        fg = accent;
        bg = foreground;
      };
      "ui.virtual.whitespace" = {
        fg = accent;
      };
      "ui.virtual.indent-guide" = {
        fg = foreground;
      };
      "ui.virtual.inlay-hint" = {
        fg = black;
        bg = yellow;
      };
      "ui.virtual.wrap" = {
        fg = foreground;
      };
      "ui.menu" = {
        fg = accent;
        bg = background;
      };
      "ui.menu.selected" = {
        fg = black;
        bg = accent;
      };
      "ui.menu.scroll" = {
        fg = accent;
        bg = foreground;
      };
      "ui.selection" = {
        fg = black;
        bg = accent;
      };
      "ui.selection.primary" = {
        fg = black;
        bg = accent;
      };
      "warning" = {
        fg = yellow;
      };
      "error" = {
        fg = red;
        modifiers = [ "bold" ];
      };
      "info" = {
        fg = accent;
      };
      "hint" = {
        fg = white;
        modifiers = [ "bold" ];
      };
      "diagnostic" = {
        fg = accent;
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
          color = yellow;
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
      "comment" = foreground-dark;
      "variable" = accent;
      "variable.parameter" = yellow;
      "variable.builtin" = yellow;
      "label" = accent;
      "punctuation" = foreground;
      "keyword" = purple;
      "operator" = accent;
      "function" = {
        fg = white;
        modifiers = [ "bold" ];
      };
      "tag" = purple;
      "namespace" = accent;
      "special" = {
        fg = white;
        modifiers = [ "bold" ];
      };
      "markup" = accent;
      "markup.heading" = {
        fg = white;
        modifiers = [ "bold" ];
        underline = {
          color = white;
          style = "double_line";
        };
      };
      "markup.bold" = {
        fg = accent;
        modifiers = [ "bold" ];
      };
      "markup.italic" = {
        fg = accent;
        modifiers = [ "italic" ];
      };
      "markup.strikethrough" = {
        fg = accent;
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
        fg = foreground;
        modifiers = [ "italic" ];
      };
      "diff.plus" = green;
      "diff.delta" = blue;
      "diff.minus" = red;
    };
}
