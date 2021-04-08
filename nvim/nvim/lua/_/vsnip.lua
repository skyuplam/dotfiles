local g = vim.g
local stdpath = vim.fn.stdpath

g.vsnip_snippet_dir = stdpath('config') .. '/vsnip'

g.vsnip_filetypes = {
  typescript={'javascript'},
  typescriptreact={'javascript'},
  javascript={'javascript'},
  javascriptreact={'javascript'},
  gitcommit={'commit'},
  rust={'rust'}
}
