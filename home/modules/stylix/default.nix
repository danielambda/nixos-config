{ inputs, pkgs, ... }: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;

    targets.neovim.enable = false;
    targets.hyprland.enable = false;

    polarity = "dark";
    # base16Scheme = scheme "twilight";
    base16Scheme = {
      base00 = "1e1e1e";
      base01 = "323537";
      base02 = "464b50";
      base03 = "5f5a60";
      base04 = "838184";
      base05 = "a7a7a7";
      base06 = "c3c3c3";
      base07 = "ffffff";
      base08 = "f79c9c"; #changed from cf6a4c
      base09 = "cda869";
      base0A = "f9ee98";
      base0B = "8f9d6a";
      base0C = "afc4db";
      base0D = "7587a6";
      base0E = "9b859d";
      base0F = "9b703f";
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
        terminal = 16;
      };
    };

    opacity = {
      terminal = 0.8;
    };
  };
}
