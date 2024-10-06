local profile = os.getenv'NEOVIM_PROFILE'

if profile == 'obsidian' then
    require'obsidian'.setup{
        workspaces = {
            {
                name = "main",
                path = "~/obsidian"
            }
        }
    }

    vim.keymap.set('n', '<leader>oo', function() vim.cmd('ObsidianOpen') end)
end
