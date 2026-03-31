{
  description = "Géza's NixOs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-nix = {
      url = "git+https://codeberg.org/BANanaD3V/niri-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    goose-shell = {
      url = "git+https://codeberg.org/DynamicGoose/goose-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mobile-nixos = {
      url = "github:matthewcroughan/mobile-nixos/mc/611"; # TODO: use upstream in the future
      flake = false;
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

        # mobile-nixos for oneplus-enchilada
        mobile-gezaa = {
          system = "aarch64-linux";
          # modules differ from normal desktop
          includeModules = [
            (import "${inputs.mobile-nixos}/lib/configuration.nix" { device = "oneplus-enchilada"; })
            inputs.home-manager.nixosModules.home-manager
            "${self}/mobile.nix"
            "${self}/hosts/mobile-gezaa"
          ];
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };

        usb-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };
      };

      # Development shells in ./shells
      devShells = lib.eachSystem (
        system:
        let
          pkgs = lib.pkgsFor.${system};
        in
        import ./shells { inherit pkgs; }
      );

      # Easily run as VM with `nix run`
      apps = lib.eachSystem (system: rec {
        default = usb-gezaa;

        desktop-gezaa = lib.mkVMApp "desktop-gezaa";
        fw-gezaa = lib.mkVMApp "fw-gezaa";
        tp-gezaa = lib.mkVMApp "tp-gezaa";
        hp-gezaa = lib.mkVMApp "hp-gezaa";
        dl-gezaa = lib.mkVMApp "dl-gezaa";
        mobile-gezaa = lib.mkVMApp "mobile-gezaa";
        usb-gezaa = lib.mkVMApp "usb-gezaa";

        # generate option documentation using https://github.com/Thunderbottom/nix-options-doc
        gen-docs = {
          type = "app";
          program = "${lib.pkgsFor.${system}.writeShellScript "gen-docs"
            "nix run github:Thunderbottom/nix-options-doc -- -p ${self} -o options.md"
          }";
        };
      });

      # build mobile images
      packages.mobile-images =
        self.nixosConfigurations.mobile-gezaa.config.mobile.outputs.android.android-fastboot-images;
      # Library functions for external use
      lib = lib;
    };
}
