{
  description = "Géza's NixOs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

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

        cyberdeck-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };

        usb-gezaa = {
          username = "gezaa";
          userDescription = "Géza Ahsendorf";
        };
      };
      # Development shells in ./shells
      devShells = lib.eachSystem (pkgs: import ./shells { inherit pkgs; });
      # Easily run as VM with `nix run`
      apps = lib.eachSystem (pkgs: rec {
        default = usb-gezaa;

        desktop-gezaa = lib.mkVMApp "desktop-gezaa";
        fw-gezaa = lib.mkVMApp "fw-gezaa";
        tp-gezaa = lib.mkVMApp "tp-gezaa";
        hp-gezaa = lib.mkVMApp "hp-gezaa";
        dl-gezaa = lib.mkVMApp "dl-gezaa";
        cyberdeck-gezaa = lib.mkVMApp "cyberdeck-gezaa";
        usb-gezaa = lib.mkVMApp "usb-gezaa";
      });
      # Library functions for external use
      lib = lib;
    };
}
