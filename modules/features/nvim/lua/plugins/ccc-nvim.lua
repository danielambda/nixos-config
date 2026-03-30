
return {
  'ccc.nvim';
  lazy = false;
  after = function ()
    vim.opt.termguicolors = true

    require'ccc'.setup {
      lsp = false;
      highlighter = {
        auto_enable = true;
        lsp = true;
      };
    }
  end;
}
