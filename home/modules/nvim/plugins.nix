{ pkgs, inputs, ... }:
let 
  configure = plugin: config: {
	inherit plugin;
	type = "lua";
	config = builtins.readFile ./lua/plugins/${config};
  }; 

  configureInline = plugin: config: {
	inherit plugin config;
	type = "lua";
  }; 
in {
  imports = [./base16-nvim.nix];

  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        langmapper-nvim = prev.vimUtils.buildVimPlugin {
          name = "langmapper-nvim";
          src = inputs.langmapper-nvim;
        };
      };
    })
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    (configure telescope-nvim "telescope.lua")
    (configure nvim-treesitter.withAllGrammars "treesitter.lua")
    (configure undotree "undotree.lua")
    indentLine #TODO configure
    vim-nix
    (configureInline lualine-nvim /*lua*/''
      require'lualine'.setup()'')
    (configure nvim-lspconfig "lsp.lua")
    (configure nvim-cmp "cmp.lua")
    cmp-nvim-lsp
    lazydev-nvim
    ccc-nvim #TODO configure
    (configureInline transparent-nvim /*lua*/''
      require'transparent'.setup({ auto = true })'')
    (configure langmapper-nvim "langmapper.lua")
  ];
}

