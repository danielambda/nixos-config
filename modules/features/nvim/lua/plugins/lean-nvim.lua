return {
  'lean.nvim';
  lazy = false;
  after = function()
    require'lean'.setup{ mappings = true }
  end;
}
