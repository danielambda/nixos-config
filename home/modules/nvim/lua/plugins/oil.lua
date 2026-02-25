require'oil'.setup {
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-p>"] = "actions.preview",
    ["<C-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  }
}
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- close deleted files via oil.nvim
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(args)
    local parse_url = function(url)
      return url:match("^.*://(.*)$")
    end

    if args.data.err then
      return
    end

    for _, action in ipairs(args.data.actions) do
      if action.type == "delete" and action.entry_type == "file" then
        local path = parse_url(action.url)
        local bufnr = vim.fn.bufnr(path)
        if bufnr == -1 then
          return
        end

        local winnr = vim.fn.win_findbuf(bufnr)[1]
        if not winnr then
          vim.cmd("bw! " .. bufnr)
          return
        end

        vim.fn.win_execute(winnr, "bfirst | bw " .. bufnr)
      end
    end
  end,
})
