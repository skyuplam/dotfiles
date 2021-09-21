local M = {}
local g = vim.g

M.setup = function()
  g.nvim_tree_quit_on_open = 1
  g.nvim_tree_follow = 1
end

return M
