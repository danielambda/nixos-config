{ inputs, self, ... }: {
  flake.nvimWrapper = { config, wlib, lib, pkgs, ... }: {
    imports = [wlib.wrapperModules.neovim];

    options.settings.test_mode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        If true, use impure config instead for fast edits

        Both versions of the package may be installed simultaneously
      '';
    };

    config = {
      settings = {
        dont_link = true;
        config_directory =
          if config.settings.test_mode
            then "${self.flake-dir}/modules/features/nvim"
            else ./.;

        aliases =
          if config.settings.test_mode
            then []
            else ["vim" "vi" "v"];
      };

      specs.initLua = {
        data = null;
        before = ["MAIN_INIT"];
        config = /*lua*/''
          require('init')
          require('lz.n').load('plugins')
        '';
      };

      specs.start = let
        # TODO
        # stella-grammar = pkgs.tree-sitter.buildGrammar {
        #   language = "stella";
        #   version = "0.0.1";
        #   src = ./stella-ts;
        # };
      in with pkgs.vimPlugins; [
        lz-n

        base16-nvim
        ccc-nvim
        cmp-nvim-lsp
        cmp-path
        cmp_luasnip
        comment-nvim
        gitsigns-nvim
        langmapper-nvim
        lean-nvim
        lsp_lines-nvim
        lspsaga-nvim
        lualine-nvim
        luasnip
        mini-nvim
        neodev-nvim
        nvim-cmp
        nvim-lspconfig
        nvim-metals
        nvim-sops
        nvim-treesitter.withAllGrammars #(nvim-treesitter.grammarToPlugin stella-grammar)
        nvim-ts-autotag
        oil-nvim
        otter-nvim
        telescope-nvim
        undotree
        vim-nix
        vim-sleuth
        vim-tmux-navigator
        vim-visual-multi
      ];

      info = {
        difftastic.path = lib.getExe pkgs.difftastic;
        metals.path = lib.getExe pkgs.metals;
        colors = self.hashColors;
      };

      extraPackages = [
        pkgs.ripgrep
        pkgs.wl-clipboard
      ];
    };
  };

  perSystem = { pkgs, ... }: {
    packages.nvim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;
      imports = [self.nvimWrapper];
      binName = "nvim";
      settings.test_mode = false;
    };

    packages.testvim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;
      imports = [self.nvimWrapper];
      binName = "testvim";
      settings.test_mode = true;
    };
  };
}
