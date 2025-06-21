local otter = require'otter'
otter.setup {
  lsp = {
    diagnostic_update_events = { "TextChanged" }
  }
}

vim.keymap.set('n', '<leader>oa', otter.activate, { desc = 'Otter activate' })
