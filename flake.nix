{
  description = "Géza's NixOs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
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
      url = "github:mwlaboratories/mobile-nixos/sdm845-bleeding-edge"; # TODO: use upstream in the future
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
        inherit self inputs lib;
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
      packages = lib.eachSystem (
        system:
        let
          pkgs = lib.pkgsFor.${system};
        in
        {
          mobile-images = {
            all = self.nixosConfigurations.mobile-gezaa.config.mobile.outputs.android.android-fastboot-images;
            boot = self.nixosConfigurations.mobile-gezaa.config.mobile.outputs.android.android-bootimg;
            system = self.nixosConfigurations.mobile-gezaa.config.mobile.outputs.generatedFilesystems.rootfs;
          };

          pkgs = pkgs.lib.packagesFromDirectoryRecursive {
            callPackage = pkgs.callPackage;
            directory = ./pkgs;
          };

          wrappers =
            let
              pkgs-with-wrappers = pkgs.lib.mergeAttrs pkgs {
                inputs = inputs;
                system = system;
              };
            in
            pkgs.lib.packagesFromDirectoryRecursive {
              callPackage = pkgs.lib.callPackageWith pkgs-with-wrappers;
              directory = ./wrappers;
            };
        }
      );

      # Library functions for external use
      lib = lib;
    };
}
