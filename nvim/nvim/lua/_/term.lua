local has_toggle_term, toggle_term = pcall(require, 'toggleterm')

local M = {}

function M.setup()
  if not has_toggle_term then return end
  local Terminal = require('toggleterm.terminal').Terminal
  local tig = Terminal:new({
    cmd='tig status',
    hidden=true,
    direction='float',
    float_opts={border=_.style.current.border}
  })

  local function toggleTig() tig:toggle() end

  toggle_term.setup({})
  vim.keymap.set('n', '<leader>gs', toggleTig, {silent=true, noremap=true})
end

return M
