{
  pkgs,
  username,
  ...
}:
{
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  environment.systemPackages = [ pkgs.helix ];

  # Config
  systemd.services.helixConfig =
    let
      config = pkgs.writeText "helix-config.toml" ''
        theme = "minimal"

        [editor]
        color-modes = true
        line-number = "relative"
        mouse = false

        [editor.cursor-shape]
        insert = "bar"
        normal = "block"
        select = "block"

        [editor.indent-guides]
        character = "▏"
        render = true
        skip-levels = 1

        [editor.soft-wrap]
        enable = true
        max-indent-retain = 0
        max-wrap = 25
        wrap-indicator = "▷ "
      '';
      languages = pkgs.writeText "helix-languages.toml" ''
        [[grammar]]
        name = "nu"

        [grammar.source]
        git = "https://github.com/nushell/tree-sitter-nu"
        rev = "6544c4383643cf8608d50def2247a7af8314e148"

        [[language]]
        auto-format = true
        name = "nix"

        [language.formatter]
        command = "nixfmt"

        [[language]]
        name = "haskell"
        auto-format = true
        formatter = { command = "stylish-haskell", args = [] }
      '';
      theme = pkgs.writeText "helix-theme-minimal.toml" ''
        attribute = "#BA68C8"
        comment = "#616161"
        constant = "#FFD600"
        "constant.numeric" = "#66BB6A"
        constructor = "#FFD600"
        "diff.delta" = "#42A5F5"
        "diff.minus" = "#F44336"
        "diff.plus" = "#66BB6A"
        keyword = "#BA68C8"
        label = "#e0e0e0"
        markup = "#e0e0e0"
        namespace = "#e0e0e0"
        operator = "#e0e0e0"
        punctuation = "#9E9E9E"
        string = "#66BB6A"
        tag = "#BA68C8"
        type = "#42A5F5"
        "ui.cursor.secondary" = "#e0e0e0"
        variable = "#e0e0e0"
        "variable.builtin" = "#FFD600"
        "variable.parameter" = "#FFD600"

        [diagnostic]
        fg = "#e0e0e0"

        ["diagnostic.deprecated"]
        modifiers = ["crossed_out"]

        ["diagnostic.error".underline]
        color = "#F44336"
        style = "curl"

        ["diagnostic.hint".underline]
        color = "#ffffff"
        style = "dashed"

        ["diagnostic.info".underline]
        color = "#ffffff"
        style = "dotted"

        ["diagnostic.unnecessary"]
        modifiers = ["dim"]

        ["diagnostic.warning".underline]
        color = "#FFD600"
        style = "curl"

        [error]
        fg = "#F44336"
        modifiers = ["bold"]

        [function]
        fg = "#ffffff"
        modifiers = ["bold"]

        [hint]
        fg = "#ffffff"
        modifiers = ["bold"]

        [info]
        fg = "#e0e0e0"

        ["markup.bold"]
        fg = "#e0e0e0"
        modifiers = ["bold"]

        ["markup.heading"]
        fg = "#ffffff"
        modifiers = ["bold"]

        ["markup.heading".underline]
        color = "#ffffff"
        style = "double_line"

        ["markup.italic"]
        fg = "#e0e0e0"
        modifiers = ["italic"]

        ["markup.link"]
        fg = "#42A5F5"

        ["markup.link".underline]
        color = "blue"
        style = "line"

        ["markup.quote"]
        fg = "#9E9E9E"
        modifiers = ["italic"]

        ["markup.strikethrough"]
        fg = "#e0e0e0"
        modifiers = ["crossed_out"]

        [special]
        fg = "#ffffff"
        modifiers = ["bold"]

        ["ui.background"]
        bg = "#000000"

        ["ui.cursor"]
        bg = "#ffffff"
        fg = "#000000"

        ["ui.cursor.match"]
        bg = "#ffffff"
        fg = "#000000"

        ["ui.cursor.select"]
        bg = "#9E9E9E"
        fg = "#e0e0e0"

        ["ui.help"]
        bg = "#0f0f0f"
        fg = "#e0e0e0"

        ["ui.linenr"]
        bg = "#000000"
        fg = "#e0e0e0"

        ["ui.linenr.selected"]
        bg = "#000000"
        fg = "#9E9E9E"

        ["ui.menu"]
        bg = "#0f0f0f"
        fg = "#e0e0e0"

        ["ui.menu.scroll"]
        bg = "#9E9E9E"
        fg = "#e0e0e0"

        ["ui.menu.selected"]
        bg = "#e0e0e0"
        fg = "#000000"

        ["ui.popup"]
        bg = "#0f0f0f"
        fg = "#e0e0e0"

        ["ui.selection"]
        bg = "#e0e0e0"
        fg = "#000000"

        ["ui.selection.primary"]
        bg = "#e0e0e0"
        fg = "#000000"

        ["ui.statusline"]
        bg = "#0f0f0f"
        fg = "#e0e0e0"

        ["ui.statusline.insert"]
        bg = "#FFD600"
        fg = "#000000"

        ["ui.statusline.normal"]
        bg = "#42A5F5"
        fg = "#000000"

        ["ui.statusline.select"]
        bg = "#BA68C8"
        fg = "#000000"

        ["ui.text"]
        fg = "#e0e0e0"

        ["ui.text.focus"]
        bg = "#e0e0e0"
        fg = "#000000"

        ["ui.virtual.indent-guide"]
        fg = "#9E9E9E"

        ["ui.virtual.inlay-hint"]
        bg = "#FFD600"
        fg = "#000000"

        ["ui.virtual.ruler"]
        bg = "#9E9E9E"
        fg = "#e0e0e0"

        ["ui.virtual.whitespace"]
        fg = "#e0e0e0"

        ["ui.virtual.wrap"]
        fg = "#9E9E9E"

        ["ui.window"]
        fg = "#e0e0e0"

        [warning]
        fg = "#FFD600"
      '';
      copy-config = pkgs.writeShellScript "copy-helix-config.sh" ''
        ${pkgs.coreutils}/bin/mkdir -m 777 -p /home/${username}/.config/helix/
        ${pkgs.coreutils}/bin/mkdir -m 777 -p /home/${username}/.config/helix/themes/
        ${pkgs.coreutils}/bin/ln -sf ${config} /home/${username}/.config/helix/config.toml
        ${pkgs.coreutils}/bin/ln -sf ${languages} /home/${username}/.config/helix/languages.toml
        ${pkgs.coreutils}/bin/ln -sf ${theme} /home/${username}/.config/helix/themes/minimal.toml
      '';
    in
    {
      description = "Copy helix user config";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = copy-config;
      };
    };
}
