return {
  'lsp_lines.nvim';
  lazy = false;
  after = function()
    vim.diagnostic.config({ virtual_text = true })
    vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    vim.keymap.set(
      "",
      "<Leader>l",
      require("lsp_lines").toggle,
      { desc = "Toggle lsp_lines" }
    )
  end
}
