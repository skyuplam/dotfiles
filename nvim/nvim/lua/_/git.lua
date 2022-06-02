local has_neogit, neogit = pcall(require, 'neogit')

local M = {}

local function setup() return {integrations={diffview=true}} end

function M.setup()
  if not has_neogit then return end
  neogit.setup(setup())
end

return M
