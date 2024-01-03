local has_toggle_term, toggle_term = pcall(require, 'toggleterm')
local map = require('tl.common').map

local M = {}

local Terminal = require('toggleterm.terminal').Terminal

local tig = Terminal:new({
  cmd = 'tig status',
  direction = 'float',
  float_opts = { border = tl.style.current.border },
})

function M.toggleTig()
  if not has_toggle_term then
    return
  end
  tig:toggle()
end

function M.setup()
  if not has_toggle_term then
    return
  end

  toggle_term.setup({})
  map(
    'n',
    '<leader>gs',
    M.toggleTig,
    { silent = true, noremap = true, desc = 'Open Tig' }
  )
end

return M
