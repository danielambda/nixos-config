local lspconfig = require'lspconfig'

require'neodev'.setup()
lspconfig.lua_ls.setup{}

lspconfig.nixd.setup {
  cmd = { "nixd" };
  settings = {
    nixd = {
      nixpkgs = { expr = "import <nixpkgs> {}"; };
      options = {
        nixos = {
          expr = '(builtins.getFlake "/home/daniel/nix").nixosConfigurations.nixos.options';
        };
        home_manager = {
          expr =  '(builtins.getFlake "/home/daniel/nix").homeConfigurations.daniel.options';
        };
      };
    };
  };
};

lspconfig.omnisharp.setup({
  cmd = { "OmniSharp", "--languageserver" };
  enable_roslyn_analyzers = true;
  organize_imports_on_format = true;
  enable_import_completion = true;
  on_attach = function(_, buffer)
    local opts = { buffer = buffer }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>fm', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end
})
require'lspconfig.configs'.omnisharp = {
  default_config = {
    root_dir = lspconfig.util.root_pattern('*.sln', '*.csproj', '.git'),
  }
}

-- lspconfig.hls.setup{} -- Done by ./haskell-tools.lua
-- lspconfig.metals.setup{} -- Done by ./metals.lua
lspconfig.rust_analyzer.setup{}
lspconfig.pyright.setup{}
lspconfig.clangd.setup{}
lspconfig.ts_ls.setup{}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require'cmp_nvim_lsp'.default_capabilities())
