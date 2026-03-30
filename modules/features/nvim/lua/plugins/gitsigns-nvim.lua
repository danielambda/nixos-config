return {
  'gitsigns.nvim';
  lazy = false;
  after = function()
    require'gitsigns'.setup();
  end
}
