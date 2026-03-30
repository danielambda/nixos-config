return {
  'comment.nvim';
  lazy = false;
  after = function()
    require'Comment'.setup();
  end
}
