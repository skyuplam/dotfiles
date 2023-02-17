local has_wk, wk = pcall(require, 'which-key')

local M = {}

function M.setup()
  if not has_wk then return end

  vim.o.timeout = true
  vim.o.timeoutlen = 300

  wk.setup({});
end

return M;

