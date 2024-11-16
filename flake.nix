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
    utils,
    ...
  } @ inputs: {
    nixConfigurations = {
      desktop-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./common.nix
          ./hosts/desktop-gezaa.nix
        ];
      };
      
      fw-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./common.nix
          ./hosts/fw-gezaa.nix
        ];
      };
      
      tp-gezaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./common.nix
          ./hosts/tp-gezaa.nix
        ];
      };
    };
  };  
}
