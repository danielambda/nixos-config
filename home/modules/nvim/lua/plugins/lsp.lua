local lspconfig = require'lspconfig'

lspconfig.pyright.setup{}

lspconfig.ts_ls.setup{}

lspconfig.rust_analyzer.setup{}

lspconfig.omnisharp.setup{
	cmd = { "omnisharp", "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) };
}

lspconfig.hls.setup{}

lspconfig.lua_ls.setup{}

lspconfig.nixd.setup{}
