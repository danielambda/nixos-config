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
    langmapper-nvim = {
      url = "github:Wansmer/langmapper.nvim";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; };
      modules = [./nixos];
    };

    homeConfigurations.daniel = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs system; };
      modules = [./home];
    };
  };
}
