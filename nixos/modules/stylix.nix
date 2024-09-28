{ inputs, pkgs, shared, ... }: { 
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = import /${shared}/stylix { inherit pkgs; };

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
  ];
}
