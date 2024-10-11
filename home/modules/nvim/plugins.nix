{ pkgs, inputs, ... }:
let
  configure = plugin: config: {
	inherit plugin;
	config = builtins.readFile ./lua/plugins/${config};
	type = "lua";
  };

  configureInline = plugin: config: {
	inherit plugin config;
	type = "lua";
  };
in {
  imports = [./base16-nvim.nix];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    (configure telescope-nvim "telescope.lua")
    (configure nvim-treesitter.withAllGrammars "treesitter.lua")
    (configure undotree "undotree.lua")
    indentLine #TODO configure
    vim-nix
    (configureInline comment-nvim /*lua*/''
      require'Comment'.setup()'')
    (configureInline lualine-nvim /*lua*/''
      require'lualine'.setup()'')
    (configure nvim-lspconfig "lsp.lua")
    (configure nvim-cmp "cmp.lua")
    cmp-nvim-lsp
    cmp_luasnip
    cmp-path
    neodev-nvim
    ccc-nvim #TODO configure
    (configureInline transparent-nvim /*lua*/''
      require'transparent'.setup { auto = true }'')
    (configure luasnip "luasnip.lua")
    vim-sleuth
    (configure gitsigns-nvim "gitsigns.lua")
    (configureInline mini-nvim /*lua*/''
      require'mini.ai'.setup { n_lines = 500 }
      require'mini.surround'.setup()
    '')
    otter-nvim

    (configure obsidian-nvim "obsidian.lua")

    (configure langmapper-nvim "langmapper.lua")
  ];

  home.packages = with pkgs; [
      #LSPs
      rust-analyzer
      pyright
      omnisharp-roslyn
      clang-tools
  ];

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
}

