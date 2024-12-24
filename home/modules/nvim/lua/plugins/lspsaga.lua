require'lspsaga'.setup {
  symbol_in_winbar = { enable = false; };
  lightbulb = { enable = false; };
}

vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>')
vim.keymap.set('n', '<leader>ca', '<Cmd>Lspsaga code_action<CR>')
vim.keymap.set('n', '<leader>rr', '<Cmd>Lspsaga rename<CR>')
