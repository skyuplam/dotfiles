local keymap = vim.keymap

-- Add a new key mapping
-- @param mode string|table Mode short-name, @see nvim_set_keymap(). Can also be list of modes to create mapping on multiple modes
-- @param lhs (string) Left-hand side {lhs} of the mapping.
-- @param rhs string|function Right-hand side {rhs} of the mapping, can be a Lua function
-- @param opts table|nil
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  keymap.set(mode, lhs, rhs, opts)
end

return {map=map};
