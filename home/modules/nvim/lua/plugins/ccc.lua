vim.opt.termguicolors = true

require'ccc'.setup({
    highlighter = {
        auto_enable = true,
        -- lsp = true,
        lsp = false,
    },
})
