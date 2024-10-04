local lspconfig = require'lspconfig'

lspconfig.lua_ls.setup{}
lspconfig.nixd.setup{}

local configByProfile =
{
    ['default'] = function()end,
    ['rust'] = function() print'aboba' lspconfig.rust_analyzer.setup{} end,
    ['obsidian'] = function()end -- TODO
}

local profile = os.getenv('NEOVIM_PROFILE') or 'default'
configByProfile[profile]()
