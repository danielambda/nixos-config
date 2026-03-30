{
  flake = rec {
    colors = { # onedark
      base00 = "20242c"; #20242c
      base01 = "333943"; #333943
      base02 = "3e4451"; #3e4451
      base03 = "545862"; #545862
      base04 = "565c64"; #565c64
      base05 = "abb2bf"; #abb2bf
      base06 = "b6bdca"; #b6bdca
      base07 = "c8ccd4"; #c8ccd4
      base08 = "fb8383"; #fb8383
      base09 = "d19a66"; #d19a66
      base0A = "e5c07b"; #e5c07b
      base0B = "98c379"; #98c379
      base0C = "56b6c2"; #56b6c2
      base0D = "61afef"; #61afef
      base0E = "c678dd"; #c678dd
      base0F = "be5046"; #be5046
    };
    hashColors = builtins.mapAttrs (_: c: "#${c}") colors;
  };
}
