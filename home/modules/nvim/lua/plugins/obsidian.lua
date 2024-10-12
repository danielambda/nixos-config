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
        },
        ['<leader>oo'] = {
            action = function() vim.cmd'ObsidianOpen' end
        },
        ['<leader>on'] = {
            action = function() vim.cmd'ObsidianNew' end
        },
        ['<leader>of'] = {
            action = function() vim.cmd'ObsidianQuickSwitch' end
        },
        ['<leader>or'] = {
            action = function() vim.cmd'ObsidianRename' end
        },
        ['<leader>oi'] = {
            action = function() vim.cmd'ObsidianPasteImage' end
        },
        ['<leader>og'] = {
            action = function() vim.cmd'ObsidianSearch' end
        },
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

    -- ui = { enable = false },
    ui = {
        enable = true,
        update_debounce = 200,
        max_file_length = 5000,
        checkboxes = {
            [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
        },
    },
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

