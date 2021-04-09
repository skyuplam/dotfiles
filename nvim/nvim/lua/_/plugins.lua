-- vim: set foldmethod=marker foldlevel=0 nomodeline:
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- ============================================================================
--  Bootstrap for packer {{{
-- ============================================================================
-- Note that this will install packer as an opt plugin; if you want packer to be
-- a start plugin, you must modify the value of install_path in the above
-- snippet.
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute(
      '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end

-- }}}
-- ============================================================================
--  Plugins {{{
-- ============================================================================

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

-- Global Variable
_G._ = {}

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt=true}

  use {
    'tpope/vim-dispatch',
    opt=true,
    cmd={'Dispatch', 'Make', 'Focus', 'Start'}
  }
  use {'andymass/vim-matchup', event='VimEnter *'}
  use {
    'iamcco/markdown-preview.nvim',
    run='cd app && yarn install',
    cmd='MarkdownPreview'
  }

  use {'sheerun/vim-polyglot'}
  use {
    'nvim-treesitter/nvim-treesitter',
    run=':TSUpdate',
    requires={
      {'nvim-treesitter/nvim-treesitter-refactor', after='nvim-treesitter'},
      {'nvim-treesitter/nvim-treesitter-textobjects', after='nvim-treesitter'},
      config='require("_.treesitter")',
      event='VimEnter *'
    }
  }
  use {'gruvbox-community/gruvbox'}
  use {'vim-jp/syntax-vim-ex'}

  -- use {'preservim/nerdtree'}
  -- use {'Xuyuanp/nerdtree-git-plugin'}

  use {'Shougo/vimproc.vim', run=':silent! !make'}
  use 'vim-scripts/vis'
  use 'editorconfig/editorconfig-vim'

  use 'mbbill/undotree'

  use 'airblade/vim-gitgutter'
  use 'mhinz/vim-signify'
  use 'tpope/vim-git'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-sleuth'

  use 'godlygeek/tabular'

  use 'SirVer/ultisnips'

  use 'iberianpig/tig-explorer.vim'
  use 'rbgrouleff/bclose.vim'
  -- Marks
  use 'kshenoy/vim-signature'
  -- Quickfix
  use {'Olical/vim-enmasse', cmd='EnMasse'}

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'junegunn/fzf.vim'
  use 'ryanoasis/vim-devicons'
  use {
    'norcalli/nvim-colorizer.lua',
    config=function() require('colorizer').setup() end
  }

  use {
    '~/dev/vim-redact-pass',
    event='VimEnter /private$TMPDIR/pass.?*/?*.txt,/dev/shm/pass.?*/?*.txt'
  }

  use {'~/dev/broot.nvim', config='vim.g.broot_replace_netrw = 1'}

  use {
    'mhartington/formatter.nvim',
    config=function() require('_.formatter').setup() end
  }

  use 'junegunn/vim-slash'
  use 'junegunn/gv.vim'
  use 'junegunn/vim-peekaboo'
  use 'junegunn/vim-easy-align'

  use 'plasticboy/vim-markdown'
  use 'mzlogin/vim-markdown-toc'

  use 'vim-scripts/utl.vim'
  use 'majutsushi/tagbar'
  use 'janko/vim-test'
  use 'tpope/vim-speeddating'
  use 'chrisbra/NrrwRgn'
  use 'mattn/calendar-vim'
  use 'inkarkat/vim-SyntaxRange'

  -- LSP/Completion
  use {
    'neovim/nvim-lspconfig',
    config=function() require '_.lsp' end,
    requires={
      {
        'tjdevries/lsp_extensions.nvim',
        config=function() require'_.statusline'.activate() end
      },
      {'tjdevries/nlua.nvim'},
      {'glepnir/lspsaga.nvim'},
      {'onsails/lspkind-nvim', config=function() require'lspkind'.init() end},
      {'nvim-lua/lsp-status.nvim'}
    }
  }

  use {
    'hrsh7th/nvim-compe',
    requires={
      {'andersevenrud/compe-tmux'},
      {'hrsh7th/vim-vsnip', config=function() require('_.vsnip') end},
      {'hrsh7th/vim-vsnip-integ'},
      {'nvim-lua/plenary.nvim'},
      {'tamago324/compe-zsh'}
    }
  }

  use {'Shougo/deol.nvim'}

  use {'p00f/nvim-ts-rainbow'}
end)
---}}}
