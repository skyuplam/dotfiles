local has_toggle_term, toggle_term = pcall(require, 'toggleterm')

local M = {}

local Terminal = require('toggleterm.terminal').Terminal

local tig = Terminal:new({
  cmd='tig status',
  hidden=true,
  direction='float',
  float_opts={border=tl.style.current.border}
})

function M.toggleTig()
  if not has_toggle_term then return end
  tig:toggle()
end

function M.setup()
  if not has_toggle_term then return end

  toggle_term.setup({})
  vim.keymap.set('n', '<leader>gs', M.toggleTig, {silent=true, noremap=true})
end

return M
