return {
  'nvim-treesitter';
  after = function ()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if lang then
          pcall(vim.treesitter.start, args.buf, lang)
        end
      end,
    })

    vim.treesitter.query.set("haskell", "injections", [[
    (apply
      function: (apply
        function: (variable) @func
        (#any-of? @func "execute" "execute_" "query" "query_"))
      argument: (literal (string) @injection.content
      (#set! injection.language "sql")
      (#offset! @injection.content  0 1 0 -1)))

    (apply
      argument: (quasiquote
        (quoter) @quoter
        (#eq? @quoter "sql")
        (quasiquote_body) @injection.content
        (#set! injection.language "sql")))
    ]])
  end;
}
