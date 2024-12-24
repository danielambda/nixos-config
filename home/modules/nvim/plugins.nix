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
    vim-nix
    (configureInline comment-nvim /*lua*/''require'Comment'.setup()'')
    (configureInline lualine-nvim /*lua*/''require'lualine'.setup()'')
    (configure nvim-lspconfig "lsp.lua")
    (configure nvim-cmp "cmp.lua")
    cmp-nvim-lsp
    vim-tmux-navigator
    cmp_luasnip
    cmp-path
    neodev-nvim
    (configure ccc-nvim "ccc.lua")
    (configure luasnip "luasnip.lua")
    vim-sleuth
    (configureInline gitsigns-nvim /*lua*/ ''require 'gitsigns'.setup {}'')
    (configureInline mini-nvim /*lua*/''
      require'mini.ai'.setup { n_lines = 500 }
      require'mini.surround'.setup()
    '')
    otter-nvim
    (configureInline vimtex /*lua*/''
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
    '')
    (configure obsidian-nvim "obsidian.lua")
    (configureInline nvim-ts-autotag /*lua*/''require'nvim-ts-autotag'.setup {}'')

    (configure langmapper-nvim "langmapper.lua")
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

