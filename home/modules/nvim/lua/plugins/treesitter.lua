require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = { enable = true },
}

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
