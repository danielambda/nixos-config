local luasnip = require'luasnip'
local snippet = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

vim.keymap.set({ 'i', 's' }, '<A-l>', function ()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<A-h>', function() 
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

local configByProfile = {
    ['obsidian'] = function ()
        luasnip.add_snippets('markdown', {
            snippet('sum', {
                t'\\sum_{', i(1), t'}^{', i(2), t'}'
            })
        })
    end,
    ['default'] = function () end
}

local profile = os.getenv'NEOVIM_PROFILE' or 'default'
configByProfile[profile]()
