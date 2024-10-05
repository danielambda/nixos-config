local profile = os.getenv'NEOVIM_PROFILE' or 'default'

if profile == 'obsidian' then
    require'obsidian'.setup{
        workspaces = {
            {
                name = "main",
                path = "~/obsidian"
            }
        }
    }
end
