{ pkgs, ... }: {
  home.packages = with pkgs; [
    telegram-desktop
    obsidian
    vial
    discord
    # direnv
  ];
}
