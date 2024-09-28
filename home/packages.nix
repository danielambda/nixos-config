{ pkgs, lib, shared, ... }: {
  home.packages = with pkgs; [
    telegram-desktop
    (import /${shared}/scripts/rustTemp.nix { inherit pkgs lib; })
    obsidian
    vial
  ];
}
