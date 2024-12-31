{ pkgs, config, ... }:
let
  coloringLines = builtins.attrValues (
    builtins.mapAttrs (name: value: "${name} = '#${value}'")
      config.stylix.base16Scheme
  );
  coloring = builtins.foldl' (x: y: "${x}, ${y}")
    (builtins.head coloringLines) #seed
    (builtins.tail coloringLines);
in {
  programs.neovim.plugins = [{
    plugin = pkgs.vimPlugins.base16-nvim;
    type = "lua"; #TODO manage stylix dependency properly
    config = /*lua*/''
      local base16 = require'base16-colorscheme'

      base16.with_config {
        telescope = false; --otherwise it bugs
      }
      base16.setup {${coloring}}
    '';
  }];
}
