local profile = os.getenv'NEOVIM_PROFILE'

if profile == 'obsidian' then
    require'obsidian'.setup{
        workspaces = {
            {
                name = 'main',
                path = '~/obsidian'
            }
        },

        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },

        mappings = {
            ['gf'] = {
                action = function()
                    return require'obsidian'.util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            ['<cr>'] = {
                action = function()
                    return require'obsidian'.util.smart_action()
                end,
                opts = { buffer = true, expr = true },
            },
            ['<leader>ch'] = {
                action = function ()
                    return require'obsidian'.util.toggle_checkbox()
                end,
                opts = { buffer = true },
            }
        },

        -- Where to put new notes. Valid options are
        --  * 'current_dir' - put new notes in same directory as the current buffer.
        --  * 'notes_subdir' - put new notes in the default notes subdirectory.
        new_notes_location = 'notes_subdir',

        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ''
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. '-' .. suffix
        end,

        -- Optional, customize how note file names are generated given the ID, target directory, and title.
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
            -- This is equivalent to the default behavior.
            local path = spec.dir / tostring(spec.id)
            return path:with_suffix('.md')
        end,

        -- Optional, customize how wiki links are formatted. You can set this to one of:
        --  * 'use_alias_only', e.g. '[[Foo Bar]]'
        --  * 'prepend_note_id', e.g. '[[foo-bar|Foo Bar]]'
        --  * 'prepend_note_path', e.g. '[[foo-bar.md|Foo Bar]]'
        --  * 'use_path_only', e.g. '[[foo-bar.md]]'
        -- Or you can set it to a function that takes a table of options and returns a string, like this:
        wiki_link_func = function(opts)
            return require'obsidian.util'.wiki_link_id_prefix(opts)
        end,

        -- Optional, customize how markdown links are formatted.
        markdown_link_func = function(opts)
            return require'obsidian.util'.markdown_link(opts)
        end,

        -- Either 'wiki' or 'markdown'.
        preferred_link_style = 'wiki',

        disable_frontmatter = true,

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        ---@param url string
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            vim.fn.jobstart({'open', url})  -- Mac OS
            -- vim.fn.jobstart({'xdg-open', url})  -- linux
            -- vim.cmd(':silent exec '!start ' .. url .. ''') -- Windows
            -- vim.ui.open(url) -- need Neovim 0.10.0+
        end,

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
        -- file it will be ignored but you can customize this behavior here.
        ---@param img string
        follow_img_func = function(img)
            vim.fn.jobstart { 'qlmanage', '-p', img }  -- Mac OS quick look preview
            -- vim.fn.jobstart({'xdg-open', url})  -- linux
            -- vim.cmd(':silent exec '!start ' .. url .. ''') -- Windows
        end,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = true,

        picker = {
            name = 'telescope.nvim',
            -- Optional, configure key mappings for the picker. These are the defaults.
            -- Not all pickers support all mappings.
            note_mappings = {
                -- Create a new note from your query.
                new = '<C-x>',
                -- Insert a link to the selected note.
                insert_link = '<C-l>',
            },
            tag_mappings = {
                -- Add tag(s) to current note.
                tag_note = '<C-x>',
                -- Insert a tag at the current location.
                insert_tag = '<C-l>',
            },
        },

        sort_by = 'modified',
        sort_reversed = true,

        -- Set the maximum number of lines to read from notes on disk when performing certain searches.
        search_max_lines = 1000,

        open_notes_in = 'current',

        ui = {
            enable = true,  -- set to false to disable all additional syntax features
            update_debounce = 200,  -- update delay after a text change (in milliseconds)
            max_file_length = 5000,  -- disable UI features for files with more than this many lines
            checkboxes = {
                [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
                ['x'] = { char = '', hl_group = 'ObsidianDone' },
            },
            bullets = { char = '•', hl_group = 'ObsidianBullet' },
            external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
            reference_text = { hl_group = 'ObsidianRefText' },
            highlight_text = { hl_group = 'ObsidianHighlightText' },
            tags = { hl_group = 'ObsidianTag' },
            block_ids = { hl_group = 'ObsidianBlockID' },
            hl_groups = {
                ObsidianTodo = { bold = true, fg = '#f78c6c' },
                ObsidianDone = { bold = true, fg = '#89ddff' },
                ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
                ObsidianTilde = { bold = true, fg = '#ff5370' },
                ObsidianImportant = { bold = true, fg = '#d73128' },
                ObsidianBullet = { bold = true, fg = '#89ddff' },
                ObsidianRefText = { underline = true, fg = '#c792ea' },
                ObsidianExtLinkIcon = { fg = '#c792ea' },
                ObsidianTag = { italic = true, fg = '#89ddff' },
                ObsidianBlockID = { italic = true, fg = '#89ddff' },
                ObsidianHighlightText = { bg = '#75662e' },
            },
        },

        attachments = {
            img_folder = 'assets/imgs',  -- This is the default

            img_name_func = function()
                return string.format('%s-', os.time())
            end,

            img_text_func = function(client, path)
                path = client:vault_relative_path(path) or path
                return string.format('![%s](%s)', path.name, path)
            end,
        },
    }

    vim.keymap.set('n', '<leader>oo', function() vim.cmd('ObsidianOpen') end)
end
