local has_nt, nt = pcall(require, 'nvim-tree')


local M = {}

M.setup = function()

  if not has_nt then return end

  nt.setup {
      auto_close          = true,
      update_focused_file = {
        enable = true,
      },
  }
end

return M
