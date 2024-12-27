{ pkgs, ... }: {
  home.packages = with pkgs; [
    pyright
  ];
}

