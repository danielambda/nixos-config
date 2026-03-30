local keymap = vim.keymap.set

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

keymap('n', '<leader>q', vim.diagnostic.setloclist)

keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' } )

keymap('x', '<leader>y', '"+y')
keymap('n', '<leader>Y', '"+yg_')
keymap('n', '<leader>y', '"+y')

keymap('n', '<leader>p', '"+p')
keymap('n', '<leader>P', '"+P')
keymap('x', '<leader>p', '"+p')
keymap('x', '<leader>P', '"+P')

keymap('x', '<leader>d', '"_d')
keymap('n', '<leader>D', '"_dg_')
keymap('n', '<leader>d', '"_d')

keymap('x', '<leader>c', '"_c')
keymap('n', '<leader>C', '"_cg_')
keymap('n', '<leader>c', '"_c')

keymap('n', '<leader>q', function()
    local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
    local action = qf_winid > 0 and 'cclose' or 'copen'
    vim.cmd('botright '..action)
end, { noremap = true, silent = true })

keymap('n', '<leader>gc', ':DifftConflict<CR>', { desc = 'Show difftastic for conflict' })
