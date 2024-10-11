local obsidian = require'obsidian'

obsidian.setup {
    workspaces = {
        {
            name = 'main',
            path = '~/obsidian'
        }
    },

    note_id_func = function(title)
        title = title:gsub(" ", "-"):gsub(":", ""):lower()
        return  title .. ":" .. tostring(os.date('%Y-%m-%d-%H-%M-%S'))
    end,

    note_path_func = function(spec)
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
    end,

    wiki_link_func = obsidian.util.wiki_link_id_prefix,
    markdown_link_func = obsidian.util.markdown_link,

    preferred_link_style = "wiki",

    disable_frontmatter = false,

    note_frontmatter_func = function(note)
        if note.title then
            note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        if note.metadata == nil or vim.tbl_isempty(note.metadata) then
            return out
        end

        for k, v in pairs(note.metadata) do
            out[k] = v
        end

        return out
    end,

    follow_url_func = vim.ui.open,
    ---@param img_url string
    follow_img_func = function(img_url)
        vim.fn.jobstart({"xdg-open", img_url})
    end,

    open_app_foreground = true,

    mappings = {
        ['gf'] = {
            action = obsidian.util.gf_passthrough,
            opts = { noremap = false, expr = true, buffer = true },
        },
        ['<leader>ch'] = {
            action = obsidian.util.toggle_checkbox,
            opts = { buffer = true },
        }
    },

    picker = {
        name = "telescope.nvim",
        note_mappings = {
            new = "<C-x>",
            insert_link = "<C-l>",
        },
        tag_mappings = {
            tag_note = "<C-x>",
            insert_tag = "<C-l>",
        },
    },

    sort_by = "modified",
    sort_reversed = true,
    search_max_lines = 1000,

    callbacks = {
        enter_note = function(_, _) vim.cmd'ObsidianOpen' end,
    },

    ui = { enable = false },

    attachments = {
        img_folder = "assets/imgs",

        img_name_func = function()
            return string.format("%s-", os.time())
        end,

        img_text_func = function(client, path)
            path = client:vault_relative_path(path) or path
            return string.format("![%s](%s)", path.name, path)
        end,
    },
}

