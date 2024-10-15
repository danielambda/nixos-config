{ pkgs, ... }: {
  home.packages = with pkgs; [
    telegram-desktop
    vial
    # discord
    obsidian
    gh
  ];
}
