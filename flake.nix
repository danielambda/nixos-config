{
  description = "System of a Daniel";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    xremap.url = "github:xremap/nix-flake";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let 
    system = "x86_64-linux";
    shared = ./shared;
  in {
    # "nixos" is a sytem hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem { 
      specialArgs = {
        inherit inputs system shared;
      };
      modules = [./nixos];
    };
    # "daniel" is a username
    homeConfigurations.daniel = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs system shared;
      };
      modules = [./home];
    };
  };
}
