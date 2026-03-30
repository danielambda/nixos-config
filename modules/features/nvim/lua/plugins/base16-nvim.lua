return {
  'base16-nvim';
  lazy = false;
  after = function ()
    local base16 = require'base16-colorscheme'
    base16.with_config {
      telescope = false; --otherwise it bugs
    }
    local coloring = require(vim.g.nix_info_plugin_name)(nil, "info", "colors")
    base16.setup(coloring)
  end
}
