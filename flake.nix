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
    lib = import ./lib {
      inherit self inputs;
    };
  in {
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
  };
}
