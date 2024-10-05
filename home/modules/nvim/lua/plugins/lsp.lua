local lspconfig = require'lspconfig'

require'neodev'.setup()
lspconfig.lua_ls.setup{}
lspconfig.nixd.setup{}

local configByProfile =
{
    ['default'] = function()end,
    ['rust'] = function() lspconfig.rust_analyzer.setup{} end,
    ['obsidian'] = function()end -- TODO
}

local profile = os.getenv('NEOVIM_PROFILE') or 'default'
configByProfile[profile]()
