local luasnip = require'luasnip'
local snippet = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

vim.keymap.set({ 'i', 's' }, '<C-l>', function ()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-h>', function ()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

luasnip.add_snippets('markdown', {
    snippet('\\sum', {
        t'\\sum_{', i(1, 'i = 0'), t'}^{', i(2, '\\infty'), t'}'
    })
})

