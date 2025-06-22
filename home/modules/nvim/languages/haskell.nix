{ pkgs, lib, ... }: {
  home.packages = [pkgs.haskellPackages.hoogle];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    haskell-tools-nvim
    ghcid
    telescope_hoogle
  ];

  home.file.".config/nvim/after/ftplugin/haskell.lua".text = /*lua*/''
    require'telescope'.load_extension'hoogle'

    local hst = require'haskell-tools'
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { noremap = true, silent = true, buffer = bufnr, }
    -- haskell-language-server relies heavily on codeLenses,
    -- so auto-refresh (see advanced configuration) is enabled by default
    vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
    -- Hoogle search for the type signature of the definition under the cursor
    vim.keymap.set('n', '<space>hs', hst.hoogle.hoogle_signature, opts)
    -- Evaluate all code snippets
    vim.keymap.set('n', '<space>ea', hst.lsp.buf_eval_all, opts)
    -- Toggle a GHCi repl for the current package
    vim.keymap.set('n', '<leader>hr', hst.repl.toggle, opts)
    -- Open Telescope with Hoogle
    vim.keymap.set('n', '<leader>ht', function()
      require'telescope'.extensions.hoogle.hoogle()
    end, opts)

    local function find_cabal_root(filepath)
      local abs_path = vim.fn.fnamemodify(filepath, ":p")
      local current_dir = vim.fn.fnamemodify(abs_path, ":h")

      local function file_exists(path)
        return vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1
      end

      while current_dir ~= "/" do
        local cabal_files = vim.fn.glob(current_dir .. "/*.cabal")
        if cabal_files ~= "" then
          return current_dir
        end

        if file_exists(current_dir .. "/cabal.project")
        or file_exists(current_dir .. "/stack.yaml")
        or file_exists(current_dir .. "/project.yaml") then
          return current_dir
        end

        -- Move to parent directory
        current_dir = vim.fn.fnamemodify(current_dir, ":h")
      end

      return nil
    end

    local function get_haskell_module_name(path)
      local project_root = find_cabal_root(path)

      if project_root == nil or project_root == "" then
        local filename = vim.fn.fnamemodify(vim.fn.fnamemodify(path, ":t:r"), ":t")
        return filename:gsub('^%l', string.upper)
      end

      project_root = vim.fn.fnamemodify(project_root, ':h')

      local relative_path = vim.fn.fnamemodify(path, ':p:~:.'):gsub('^' .. project_root .. '/?', "")

      local module_path = relative_path:gsub('%.hs$', ""):gsub('/', '.')

      module_path = module_path:gsub('^src%.', "")
      module_path = module_path:gsub('^test%.', "")
      module_path = module_path:gsub('^app%.', "")
      module_path = module_path:gsub('^lib%.', "")

      local parts = {}
      for part in module_path:gmatch('[^.]+') do
        local capitalized = part:gsub('^%l', string.upper)
        table.insert(parts, capitalized)
      end

      return table.concat(parts, '.')
    end

    -- Run hpack whenever *.hs file is created or deleted via oil.nvim
    -- and add `module Module.Name where` to the newly created files
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
          if not action.entry_type == "file" then return end

          local path = parse_url(action.url)
          if not parse_url(action.url):match("%.hs$") then return end

          vim.fn.system("${lib.getExe pkgs.hpack}")
          if action.type == "create" then
            local module_name = get_haskell_module_name(path)
            if module_name and module_name ~= "" then
              vim.fn.writefile({ "module " .. module_name .. " where", "" }, path)
            end
          end
          vim.cmd("Hls restart")
        end
      end
    })
  '';
}
