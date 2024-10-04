{
  inputs = {
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        overlays = [(import rust-overlay)];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [pkgs.rust-bin.stable.latest.minimal];

        shellHook = "${pkgs.zsh}/bin/zsh";
      };
    };
}

