{pkgs, ...}:{
  imports = [
    ./python.nix
    ./haskell.nix
    ./csharp.nix
  ];

  home.packages = with pkgs.nodePackages; [
    typescript-language-server
  ];
}
