vim.opt.termguicolors = true

require'ccc'.setup {
  lsp = false;
  highlighter = {
    auto_enable = true;
    lsp = true;
  };
}
