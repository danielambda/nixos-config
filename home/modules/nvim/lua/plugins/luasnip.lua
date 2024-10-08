local luasnip = require'luasnip'
local snippet = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local configByProfile = {
    ['obsidian'] = function ()
        luasnip.add_snippets('markdown', {
            snippet('\\sum', {
                t'\\sum_{', i(1), t'}^{', i(2), t'}'
            })
        })
    end,
}

local profile = os.getenv'NEOVIM_PROFILE' or 'default'
if configByProfile[profile] then
    configByProfile[profile]()
end
