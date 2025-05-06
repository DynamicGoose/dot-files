{
  description = "Géza's NixOs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      lib = import ./lib {
        inherit self inputs;
      };
      systems = [
        "x86_64-linux"
        "i686-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      nixosConfigurations = lib.genHosts {
        desktop-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };

        fw-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };

        tp-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };

        hp-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };

        dl-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };

        usb-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };
      };

      devShells = nixpkgs.lib.genAttrs systems (
        system:
        import ./nix-shells/. {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        }
      );
    };
}
