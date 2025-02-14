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
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    langmapper-nvim = {
      url = "github:Wansmer/langmapper.nvim";
      flake = false;
    };
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    flakeDir = "/home/daniel/projects/nix/nixos-config";
  in {
    devShell.${system} = pkgs.mkShell {
      packages = with pkgs; [
        lua-language-server
        nixd
      ];
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system flakeDir; };
      modules = [./nixos];
    };

    homeConfigurations.daniel = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs system flakeDir; };
      modules = [./home];
    };
  };
}
