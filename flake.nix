{
  description = "Géza's NixOs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      desktop-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./common.nix
          ./hosts/desktop-gezaa/config.nix
          ./hosts/desktop-gezaa/hardware-configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };

      fw-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./common.nix
          ./hosts/fw-gezaa/config.nix
          ./hosts/fw-gezaa/hardware-configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
