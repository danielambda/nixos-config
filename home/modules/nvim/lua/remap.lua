vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' } )

vim.keymap.set('x', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+yg_')
vim.keymap.set('n', '<leader>y', '"+y')

vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('x', '<leader>p', '"+p')
vim.keymap.set('x', '<leader>P', '"+P')

vim.keymap.set('x', '<leader>d', '"_d')
vim.keymap.set('n', '<leader>D', '"_dg_')
vim.keymap.set('n', '<leader>d', '"_d')

vim.keymap.set('x', '<leader>c', '"_c')
vim.keymap.set('n', '<leader>C', '"_cg_')
vim.keymap.set('n', '<leader>c', '"_c')

