local M = {}

function M.bmap(mode, key, result, opts)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, opts)
end

function M.gmap(mode, key, result, opts)
  vim.api.nvim_set_keymap(mode, key, result, opts)
end

function M.augroup(group, fn)
  vim.api.nvim_command("augroup " .. group)
  vim.api.nvim_command("autocmd!")
  fn()
  vim.api.nvim_command("augroup END")
end

function M.get_icon(icon_name)
  local ICONS = {
    paste = "⍴",
    spell = "✎",
    branch = " ",
    error = "×",
    info = "●",
    warn = "!",
    hint = "›",
    lock = "",
    success = " "
    -- success = ' '
  }

  return ICONS[icon_name] or ""
end

function M.get_color(synID, what, mode)
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(synID)), what, mode)
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
