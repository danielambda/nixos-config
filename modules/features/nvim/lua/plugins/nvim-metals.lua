local ft = { "scala", "sbt", "java" }
return {
  'nvim-metals';
  lazy = true;
  ft = ft;
  after = function ()
    local metals_config = require'metals'.bare_config()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require'cmp_nvim_lsp'.default_capabilities())

    metals_config.capabilities = capabilities
    metals_config.init_options.statusBarProvider = 'on'

    metals_config.settings = {
      metalsBinaryPath = require(vim.g.nix_info_plugin_name)(nil, 'info', 'metals', 'path'),
      autoImportBuild = 'off',
      defaultBspToBuildTool = true,
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      superMethodLensesEnabled = true,
      excludedPackages = {
        'akka.actor.typed.javadsl',
        'com.github.swagger.akka.javadsl'
      },
      serverProperties = {
        '-Dmetals.enable-best-effort=true',
        '-Xmx4G',
        '-XX:+UseZGC',
        '-XX:ZUncommitDelay=30',
        '-XX:ZCollectionInterval=5',
        '-XX:+IgnoreUnrecognizedVMOptions'
      }
    }

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = ft,
      callback = function()
        require'metals'.initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end;
}
