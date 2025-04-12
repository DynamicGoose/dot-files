{
  config,
  inputs,
  username,
  ...
}:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      xdg.configFile."swayosd/style.css".text = ''
        window {
          padding: 12px 20px;
          border: Solid;
          border-radius: 10px;
          border-width: 2px;
          border-color: #e0e0e0;
          background: rgba(15, 15, 15, 0.8);
        }

        #container {
          margin: 16px;
        }

        image, label {
          color: #e0e0e0;
        }

        progressbar:disabled,
        image:disabled {
          opacity: 0.5;
        }

        progressbar {
          min-height: 6px;
          border-radius: 999px;
          background: transparent;
          border: none;
        }
        trough {
          min-height: inherit;
          border-radius: inherit;
          border: none;
          background: rgba(224, 224, 224, 0.5);
        }
        progress {
          min-height: inherit;
          border-radius: inherit;
          border: none;
          background: #e0e0e0;
        }
      '';
    };
}
