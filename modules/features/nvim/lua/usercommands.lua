local difftastic = require(vim.g.nix_info_plugin_name)(nil, 'info', 'difftastic', 'path')
vim.api.nvim_create_user_command('DifftConflict', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)

  if filepath == "'" then
    print('No file associated with current buffer')
    return
  end

  -- Check if file has conflict markers
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local has_conflict = false
  for _, line in ipairs(lines) do
    if line:match('^<<<<<<<') or line:match('^=======') or line:match('^>>>>>>>') then
      has_conflict = true
      break
    end
  end

  if not has_conflict then
    print('No git conflict markers found in current file')
    return
  end

  -- Create new terminal buffer with difft output
  vim.cmd('vnew')
  local term_bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(term_bufnr, 'difft: ' .. vim.fn.fnamemodify(filepath, ':t'))

  -- Run difft in terminal mode to preserve colors
  vim.fn.termopen(difftastic .. ' --color always "' .. filepath .. '"', {
    on_exit = function()
      vim.bo[term_bufnr].modified = false
    end
  })

  -- Switch to normal mode in terminal buffer
  vim.cmd('stopinsert')
end, {})
