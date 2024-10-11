{
  description = "Rust devshell";

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
        packages = with pkgs; [
          rust-bin.stable.latest.default
        ];

        shellHook = "${pkgs.zsh}/bin/zsh";
      };
    };
}

