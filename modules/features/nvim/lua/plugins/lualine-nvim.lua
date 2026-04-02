return {
  'lualine.nvim';
  lazy = false;
  after = function()
    require'lualine'.setup({
      options = {
        theme = 'auto';
        icons_enabled = true;
        globalstatus = true; -- one statusline for all splits
        component_separators = { left = '', right = '' };
        section_separators   = { left = '', right = '' };
      };
      sections = {
        lualine_a = { { 'mode',
          separator = { left = '' };
        } };
        lualine_b = {
          {
            'filename',
            symbols = { modified = ' ●', readonly = ' ', unnamed = '[no name]', newfile = '[new]' },
          },
          { 'filetype', icon_only = true }
        };
        lualine_c = { 'diagnostics' };

        lualine_x = { 'lsp_status' };
        lualine_y = { 'progress' };
        lualine_z = { { 'location',
          separator = { right = '' };
        } };
      };
    })
  end
}
