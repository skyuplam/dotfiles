local has_indent_blankline, indent_blankline =
    pcall(require, 'indent_blankline')

if not has_indent_blankline then return end

local M = {}

function M.setup()
  vim.opt.list = true
  vim.opt.listchars:append('space:⋅')
  vim.opt.listchars:append('eol:↴')

  indent_blankline.setup({
    space_char_blankline=' ',
    show_current_context=true,
    show_current_context_start=true,
    filetype_exclude={'help', 'packer'},
    buftype_exclude={'terminal', 'nofile'},
    show_trailing_blankline_indent=false
  })
end

return M
