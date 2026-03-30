return {
  'undotree';
  after = function ()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
  end;
}
