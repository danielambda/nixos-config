return {
  'lsp_lines.nvim';
  lazy = false;
  after = function()
    vim.diagnostic.config({ virtual_text = true })
    vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
  end
}
