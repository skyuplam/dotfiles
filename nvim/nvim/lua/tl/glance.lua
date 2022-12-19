local has_glance, glance = pcall(require, 'glance')

local M = {}

function M.setup()
  if not has_glance then return end
  glance.setup({});
end

return M
