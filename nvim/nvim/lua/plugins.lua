-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--
-- Bootstrap for packer
--
-- Note that this will install packer as an opt plugin; if you want packer to be
-- a start plugin, you must modify the value of install_path in the above
-- snippet.
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  use {'andymass/vim-matchup', event = 'VimEnter *'}
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  use {'sheerun/vim-polyglot'}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    opt = true,
    ft = {'css', 'go', 'haskell', 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'nix', 'json', 'lua', 'python', 'rust', 'toml', 'yaml'},
    cmd = {'TSBufEnable', 'TSEnableAll', 'TSModuleInfo'}
  }
  use {'ghifarit53/tokyonight-vim'}
  use {'vim-jp/syntax-vim-ex'}

  use {'preservim/nerdtree'}
  use {'Xuyuanp/nerdtree-git-plugin'}

  use {'Shougo/neco-vim'}
  use {'neoclide/coc-neco'}
  use {'Shougo/neoinclude.vim'}
  use {'jsfaint/coc-neoinclude'}
  use {'neoclide/coc.nvim', branch = 'release'}
  use {'Shougo/vimproc.vim', run = ':silent! !make'}
  use {'vim-scripts/vis'}
  use {'editorconfig/editorconfig-vim'}

  use {'mbbill/undotree'}

  use {'airblade/vim-gitgutter'}
  use {'mhinz/vim-signify'}
  use {'tpope/vim-git'}
  use {'tpope/vim-fugitive'}
  use {'tpope/vim-rhubarb'}
  use {'tpope/vim-sleuth'}

  use {'godlygeek/tabular'}

  use {'christoomey/vim-tmux-navigator'}
  use {'wellle/tmux-complete.vim'}

  use {'SirVer/ultisnips'}

  use {'iberianpig/tig-explorer.vim'}
  use {'rbgrouleff/bclose.vim'}

  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'junegunn/fzf.vim'}
  use {'ryanoasis/vim-devicons'}
  use {'norcalli/nvim-colorizer.lua'}

  use {'~/dev/vim-redact-pass', opt = true, event = 'VimEnter /private$TMPDIR/pass.?*/?*.txt'}

  use {'junegunn/vim-slash'}
  use {'junegunn/gv.vim'}
  use {'junegunn/vim-peekaboo'}

  use {'plasticboy/vim-markdown'}
  use {'mzlogin/vim-markdown-toc'}

  use {'vim-scripts/utl.vim'}
  use {'majutsushi/tagbar'}
  use {'janko/vim-test'}
  use {'tpope/vim-speeddating'}
  use {'chrisbra/NrrwRgn'}
  use {'mattn/calendar-vim'}
  use {'inkarkat/vim-SyntaxRange'}
end)
