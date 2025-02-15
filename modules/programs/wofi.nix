{ config, inputs, ... }: {
  home-manager.users.${config.modules.users.username} = { config, ... }: {
    programs.wofi = {
      enable = true;

      settings = {
        show = "drun";
        width = 512;
        height = 384;
        always_parse_args = true;
        show_all = true;
        print_command = true;
        prompt = "";
        layer = "overlay";
        insensitive = true;
        content_halign = "top";
        allow_images = true;
      };

      style = ''
        #window {
          margin: 0px;
          border: 2px solid #e0e0e0;
          border-radius: 10px;
          background: rgba(15, 15, 15, 0.999);
          font-size: 16px;
          font-weight: Bold;
        }

        #input {
        border-radius: 8px;
          color: #ffffff;
          background-color: #181818;
        }

        #outer-box {
          margin: 8px;
          border: none;
          background-color: #0f0f0f;
          border-radius: 8px;
        }
        
        #text {
          margin: 0px 8px 0px 8px;
          border: none;
          color: #ffffff;
        }

        #entry:selected {
        	background-color: #e0e0e0;
        	font-weight: normal;
        	border-radius: 8px;
        }

        #text:selected {
        	background-color: #e0e0e0;
        	color: #000000;
        	font-weight: normal;
        }

        #expander-box {
          backgorund: #e0e0e0;
          color: #000000;
          font-weight: normal;
        }

        #expander-box:selected {
          background: #e0e0e0;
          color: #000000;
          font-weight: normal;
        }
      '';
    };
  };
}
