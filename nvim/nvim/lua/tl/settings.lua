-- vim: set foldmethod=marker foldlevel=0 nomodeline:
local o, opt, fn = vim.o, vim.opt, vim.fn

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-----------------------------------------------------------------------------
-- Message output on vim actions {{{1
-----------------------------------------------------------------------------
opt.shortmess = {
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = true, -- file-read message overwrites previous
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true, -- No search end msg
  c = true, -- No completion msg
  W = true, -- Don't show [w] or written when writing
}

-----------------------------------------------------------------------------
-- Window splitting and buffers {{{1
-----------------------------------------------------------------------------
o.splitbelow = true
o.splitright = true
o.eadirection = 'hor'
-- exclude usetab as we do not want to jump to buffers in already open tabs
-- do not use split or vsplit to ensure we don't open any new windows
o.switchbuf = 'useopen,uselast'
opt.fillchars = {
  fold = ' ',
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '╱', -- alternatives = ⣿ ░ ─
  msgsep = ' ', -- alternatives: ‾ ─
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}

-----------------------------------------------------------------------------
-- Fold using UFO {{{1
-----------------------------------------------------------------------------
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.foldcolumn = '0'

-----------------------------------------------------------------------------
-- Diff {{{1
-----------------------------------------------------------------------------
-- " Diffs
-- set diffopt+=vertical
-- set diffopt+=
-- set diffopt+=indent-heuristic
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
opt.diffopt = opt.diffopt
  + {
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'internal',
    'algorithm:patience',
    'indent-heuristic',
  }
-----------------------------------------------------------------------------
-- Format Options {{{1
-----------------------------------------------------------------------------
opt.formatoptions = {
  ['1'] = true,
  ['2'] = true, -- Use indent from 2nd line of a paragraph
  q = true, -- continue comments with gq"
  c = true, -- Auto-wrap comments using textwidth
  r = true, -- Continue comments when pressing Enter
  n = true, -- Recognize numbered lists
  t = false, -- autowrap lines using text width value
  j = true, -- remove a comment leader when joining lines.
  -- Only break if the line was not longer than 'textwidth' when the insert
  -- started and only at a white character that has been entered during the
  -- current insert command.
  l = true,
  v = true,
}
-----------------------------------------------------------------------------
-- Wild and file globbing {{{1
-----------------------------------------------------------------------------

o.wildcharm = ('\t'):byte()
-- " show a navigable menu for tab completion
o.wildmode = 'longest:full,full'
o.wildignorecase = true
-- Binary
opt.wildignore = {
  '*.aux',
  '*.out',
  '*.toc',
  '*.o',
  '*.obj',
  '*.dll',
  '*.jar',
  '*.pyc',
  '*.rbc',
  '*.rbo',
  '*.class',
  '*.gif',
  '*.ico',
  '*.jpg',
  '*.jpeg',
  '*.png',
  '*.avi',
  '*.wav',
  '.git',
  '.svn',
  '*.gem',
  -- Temp/System
  '*.*~',
  '*~ ',
  '*.swp',
  '.lock',
  '*/.DS_Store',
  'tags.lock',
}
o.wildoptions = 'pum'
o.pumblend = 0 -- Make popup window translucent
o.pumheight = 15

-----------------------------------------------------------------------------
-- Wild and file globbing
-----------------------------------------------------------------------------
o.gdefault = true
o.confirm = true -- vim prompt to save

opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
opt.clipboard = { 'unnamedplus' }
o.emoji = false

-----------------------------------------------------------------------------
-- Match and search {{{1
-----------------------------------------------------------------------------
o.ignorecase = true
o.smartcase = true
o.wrapscan = true -- Searches wrap around the end of the file
o.scrolloff = 9
o.sidescrolloff = 10
o.sidescroll = 1

-----------------------------------------------------------------------------
-- Grep {{{1
-----------------------------------------------------------------------------
if fn.executable('rg') == 1 then
  o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
  opt.grepformat = opt.grepformat ^ { '%f:%l:%c:%m' }
end
-----------------------------------------------------------------------------
-- Timings {{{1
-----------------------------------------------------------------------------
o.updatetime = 300
o.timeout = true
o.timeoutlen = 500
o.ttimeoutlen = 10
-----------------------------------------------------------------------------
-- Display {{{1
-----------------------------------------------------------------------------
o.conceallevel = 2
o.breakindentopt = 'sbr'
o.linebreak = true -- lines wrap at words rather than random characters
o.synmaxcol = 1024 -- don't syntax highlight long lines
o.signcolumn = 'number'
o.ruler = false
o.cmdheight = 0
o.showbreak = [[↪ ]] -- Options include -> '…', '↳ ', '→','↪ '
-----------------------------------------------------------------------------
-- List chars {{{1
-----------------------------------------------------------------------------
o.list = true -- invisible chars
opt.listchars = {
  eol = nil,
  tab = '› ',
  extends = '»',
  precedes = '«',
  nbsp = '.',
  lead = '.',
  trail = '•',
}
-----------------------------------------------------------------------------
-- Indentation
-----------------------------------------------------------------------------
o.wrap = false
o.wrapmargin = 2
o.textwidth = 80
o.autoindent = true
o.shiftround = true
o.expandtab = true
o.shiftwidth = 2
-----------------------------------------------------------------------------
-- Spelling {{{1
-----------------------------------------------------------------------------
opt.spellsuggest:prepend({ 9 })
opt.spelloptions:append({ 'camel', 'noplainbuffer' })
o.spellcapcheck = '' -- don't check for capital letters at start of sentence
opt.fileformats = { 'unix', 'mac', 'dos' }
opt.spelllang:append({ 'en', 'nb', 'cjk' })
opt.complete:append('kspell')
-----------------------------------------------------------------------------
--  BASIC SETTINGS {{{1
-----------------------------------------------------------------------------
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
--  if hidden is not set, TextEdit might fail.
o.hidden = true
o.tagcase = 'followscs'
o.tags = './.git/tags;./tags;,tags'

-- " Mouse
o.mouse = 'a'
o.mousehide = true

o.showmatch = true
o.title = true
-- these only read ".vim" files
o.secure = true -- Disable autocmd etc for project local vimrc files.
o.exrc = false -- Allow project local vimrc files example .nvimrc see :h exrc

opt.jumpoptions = { 'stack' }

o.inccommand = 'nosplit'
o.incsearch = true
o.showmode = false

-- Use one space, not two, after punctuation
o.joinspaces = false
o.textwidth = 80
o.colorcolumn = '+1'
--
-- " Line Number
o.relativenumber = true
o.number = true

o.synmaxcol = 300
o.background = 'dark'
o.termguicolors = true
o.virtualedit = 'block'

-------------------------------------------------------------------------------
-- BACKUP AND SWAPS {{{
-------------------------------------------------------------------------------

if fn.exists('$SUDO_USER') > 0 then
  o.swapfile = false -- don't create root-owned files
else
  -- Protect changes between writes. Default values of
  -- updatecount (200 keystrokes) and updatetime
  -- (4 seconds) are fine
  o.swapfile = true
  o.directory = fn.expand('$XDG_DATA_HOME/nvim/swap//')
end

if fn.exists('$SUDO_USER') > 0 then
  o.backup = false -- don't create root-owned files
  o.writebackup = false -- don't create root-owned files
else
  -- protect against crash-during-write
  o.writebackup = true
  -- but do not persist backup after successful write
  o.backup = true
  -- use rename-and-write-new method whenever safe
  o.backupcopy = 'auto'
  -- consolidate the writebackups -- not a big
  -- deal either way, since they usually get deleted
  o.backupdir = fn.expand('$XDG_DATA_HOME/nvim/backup//')
end

if fn.exists('$SUDO_USER') > 0 then
  -- don't create root-owned files
  o.undofile = false
else
  -- persist the undo tree for each file
  o.undofile = true
  o.undodir = fn.expand('$XDG_DATA_HOME/nvim/undo//')
end

if fn.exists('$SUDO_USER') > 0 then
  -- don't create root-owned files
  o.shada = ''
else
  -- Defaults:
  --   Neovim: !,'100,<50,s10,h
  -- - ! save/restore global variables (only all-uppercase variables)
  -- - '100 save/restore marks from last 100 files
  -- - /10000 Maximum number of itemsIN the search pattern history to be saved
  -- - <500 save/restore 500 lines from each register
  -- - s10 max item size 10KB
  -- - h do not save/restore 'hlsearch' setting
  o.shada = "!,'100,/10000,<500,s10,h"
  local shada_group =
    vim.api.nvim_create_augroup('MyNeovimShada', { clear = true })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'FocusGained', 'FocusLost' }, {
    pattern = '*',
    command = 'rshada|wshada',
    group = shada_group,
  })
end

-------------------------------------------------------------------------------
-- Diagnostic {{{
-------------------------------------------------------------------------------
-- Diagnostic
local icons = tl.style.icons.lsp
local signs = {
  Error = icons.error,
  Warn = icons.warn,
  Hint = icons.hint,
  Info = icons.info,
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
