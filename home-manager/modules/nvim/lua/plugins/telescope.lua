require('telescope').setup()

local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', function ()
	telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
