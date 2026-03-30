return {
  'mini.nvim';
  lazy = false;
  after = function ()
    require'mini.ai'.setup { n_lines = 500 }
    require'mini.surround'.setup {}
  end
}
