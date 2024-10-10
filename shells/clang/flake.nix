{
  description = "C/C++ devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          clang-tools
        ];

        shellHook = "${pkgs.zsh}/bin/zsh";
        NEOVIM_PROFILE = "clang";
      };
    };
}

