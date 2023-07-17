vim.g.os = vim.loop.os_uname().sysname
vim.g.sqlite_clib_path = vim.g.os == 'Darwin'
    and '/usr/lib/sqlite3/libtclsqlite3.dylib'
  or nil
-------------------------------------------------------------------------------
-- SKIP VIM PLUGINS {{{
-------------------------------------------------------------------------------
-- Stop loading built in plugins
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.logipat = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

-- Skip loading menu.vim, saves ~100ms
vim.g.did_install_default_menus = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_rrhelper = 1

-- Set them directly if they are installed, otherwise disable them. To avoid the
-- runtime check cost, which can be slow.
vim.g.python_host_skip_check = 1
vim.g.loaded_python_provider = 0

vim.g.python3_host_skip_check = 1
if vim.fn.executable('python3') == 1 then
  vim.g.python3_host_prog = vim.fn.exepath('python3')
else
  vim.g.loaded_python3_provider = 0
end

if vim.fn.executable('neovim-node-host') == 1 then
  vim.g.node_host_prog = vim.fn.exepath('neovim-node-host')
else
  vim.g.loaded_node_provider = 0
end

if vim.fn.executable('neovim-ruby-host') == 1 then
  vim.g.ruby_host_prog = vim.fn.exepath('neovim-ruby-host')
else
  vim.g.loaded_ruby_provider = 0
end

vim.g.loaded_perl_provider = 0

-- Ensure all autocommands are cleared
vim.api.nvim_create_augroup('vimrc', {})

local ok, reload = pcall(require, 'plenary.reload')
RELOAD = ok and reload.reload_module or function(...)
  return ...
end

function R(name)
  RELOAD(name)
  return require(name)
end

----------------------------------------------------------------------------------------------------
-- Global namespace
----------------------------------------------------------------------------------------------------
local namespace = {
  -- for UI elements like the winbar and statusline that need global references
  ui = { winbar = { enable = true }, foldtext = { enable = false } },
  -- some vim mappings require a mixture of commandline commands and function calls
  -- this table is place to store lua functions to be called in those mappings
  mappings = {},
}

_G.tl = tl or namespace

----------------------------------------------------------------------------------------------------
-- Plugin Configurations
----------------------------------------------------------------------------------------------------
-- Order matters here as globals needs to be instantiated first etc.

R('tl.styles')
R('tl.settings')
require('tl.prepare')()
if vim.fn.filereadable('tl.local') == 1 then
  R('tl.local')
end
R('tl.plugins')
R('tl.highlights')
