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

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
  let
    common-modules = [
      ./common.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.niri.nixosModules.niri
    ];
  in {
    nixosConfigurations = {
      desktop-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = common-modules ++ [
          ./hosts/desktop-gezaa/config.nix
          ./hosts/desktop-gezaa/hardware-configuration.nix
        ];
      };

      fw-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = common-modules ++ [
          ./hosts/fw-gezaa/config.nix
          ./hosts/fw-gezaa/hardware-configuration.nix
        ];
      };
      
      tp-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = common-modules ++ [
          ./hosts/tp-gezaa/config.nix
          ./hosts/tp-gezaa/hardware-configuration.nix
        ];
      };

      hp-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = common-modules ++ [
          ./hosts/hp-gezaa/config.nix
          ./hosts/hp-gezaa/hardware-configuration.nix
        ];
      };
      
      dl-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = common-modules ++ [
          ./hosts/dl-gezaa/config.nix
          ./hosts/dl-gezaa/hardware-configuration.nix
        ];
      };

      usb-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = common-modules ++ [
          ./hosts/usb-gezaa/config.nix
          ./hosts/usb-gezaa/hardware-configuration.nix
        ];
      };
    };
  };
}
