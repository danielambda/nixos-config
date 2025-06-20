local otter = require'otter'
otter.setup()

vim.keymap.set('n', '<leader>oa', otter.activate)
vim.keymap.set('n', '<leader>od', otter.disable)
