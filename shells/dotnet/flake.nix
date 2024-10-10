{
  description = ".NET devshell";

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
          omnisharp-roslyn
          dotnetCorePackages.sdk_9_0
        ];

        shellHook = "${pkgs.zsh}/bin/zsh";
        NEOVIM_PROFILE = "dotnet";
      };
    };
}

