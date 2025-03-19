local ls = require'luasnip'
ls.config.setup { enable_autosnippets = true }
local snippet = ls.snippet
local t = ls.text_node
local i = ls.insert_node

vim.keymap.set({ 'i',     }, '<A-y>', function () ls.expand() end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<A-l>', function () ls.jump( 1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<A-h>', function () ls.jump(-1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<A-n>', function ()
  if ls.choice_active() then ls.change_choice( 1) end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<A-N>', function ()
  if ls.choice_active() then ls.change_choice(-1) end
end, { silent = true })

ls.add_snippets('markdown', {
  snippet('\\sum', {
    t'\\sum_{', i(1, 'i = 0'), t'}^{', i(2, '\\infty'), t'}'
  })
})
