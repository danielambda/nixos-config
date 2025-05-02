{ inputs, pkgs, ... }: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;

    targets.neovim.enable = false;
    targets.waybar.enable = false;
    targets.hyprland.enable = false;

    polarity = "dark";
    base16Scheme = { # onedark
      base00 = "282c34"; #282c34
      base01 = "353b45"; #353b45
      base02 = "3e4451"; #3e4451
      base03 = "545862"; #545862
      base04 = "565c64"; #666c74
      base05 = "abb2bf"; #bbc2cf
      base06 = "b6bdca"; #c6cdda
      base07 = "c8ccd4"; #d8dce4
      base08 = "fb8383"; #fb8383
      base09 = "d19a66"; #d19a66
      base0A = "e5c07b"; #e5c07b
      base0B = "98c379"; #98c379
      base0C = "56b6c2"; #56b6c2
      base0D = "61afef"; #61afef
      base0E = "c678dd"; #c678dd
      base0F = "be5046"; #be5046
    };
    image = ./image.png;

    fonts = with pkgs; {
      monospace = {
        package = jetbrains-mono;
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        terminal = 12;
      };
    };

    opacity = {
      terminal = 0.8;
    };
  };
}
