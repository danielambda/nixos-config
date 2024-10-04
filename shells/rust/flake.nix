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
        packages = [
          pkgs.rust-analyzer
          pkgs.rust-bin.stable.latest.default
        ];

        shellHook = ''
          NEOVIM_PROFILE="rust" ${pkgs.zsh}/bin/zsh
        '';
      };
    };
}

