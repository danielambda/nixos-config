{
  description = "Haskell devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          ghc
          cabal-install
          haskell-language-server
        ];

        shellHook = ''
          cd ~/projects/haskell
          ${pkgs.zsh}/bin/zsh
        '';
      };
    };
}
