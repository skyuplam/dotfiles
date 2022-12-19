-- vim: set foldmethod=marker foldlevel=0 nomodeline:
-- A function to bootstrap packer
local download_packer = function()
  if vim.fn.input 'Download Packer? (y for yes)' ~= 'y' then return end

  local directory = string.format('%s/site/pack/packer/start/',
                                  vim.fn.stdpath 'data')

  vim.fn.mkdir(directory, 'p')
  local clone_cmd = string.format('git clone %s %s --depth 1',
                                  'https://github.com/wbthomason/packer.nvim',
                                  directory .. '/packer.nvim')
  local out = vim.fn.system(clone_cmd)

  print(out)
  print 'Downloading packer.nvim...'
  print '( You\'ll need to restart now )'
  vim.cmd [[qa]]
end

return function()
  if not pcall(require, 'packer') then
    download_packer()

    return true
  end

  return false
end
