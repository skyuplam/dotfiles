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

  use {'kevinhwang91/nvim-bqf'}
  use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons'
  }

  use {'Shougo/vimproc.vim', run=':silent! !make'}
  use 'vim-scripts/vis'
  use 'editorconfig/editorconfig-vim'

  use 'mbbill/undotree'

  use 'tpope/vim-rhubarb'
  use 'tpope/vim-sleuth'

  use 'godlygeek/tabular'

  use 'kamykn/spelunker.vim'
  use 'kamykn/popup-menu.nvim'

  use 'SirVer/ultisnips'

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
      {'lbrayner/vim-rzip'}, -- https://yarnpkg.com/getting-started/editor-sdks#supporting-go-to-definition-et-al
      {
        'tjdevries/lsp_extensions.nvim',
        config=function() require'_.statusline'.activate() end
      },
      {'tjdevries/nlua.nvim'},
      -- {'glepnir/lspsaga.nvim'},
      {'onsails/lspkind-nvim', config=function() require'lspkind'.init() end},
      {'nvim-lua/lsp-status.nvim'},
      {'ray-x/lsp_signature.nvim'},
      {'folke/lsp-colors.nvim'},
      {'kosayoda/nvim-lightbulb'},
      {
        'folke/lsp-trouble.nvim',
        requires='kyazdani42/nvim-web-devicons',
        config=function()
          local utils = require('_.utils')

          require('trouble').setup({
            signs={
              -- icons / text used for a diagnostic
              error=utils.get_icon('error'),
              warning=utils.get_icon('warn'),
              hint=utils.get_icon('hint'),
              information=utils.get_icon('info')
            },
            use_lsp_diagnostic_signs=false
          })

          utils.gmap('n', '<leader>ll', '<cmd>LspTroubleToggle<CR>',
                     {silent=true, noremap=true})
          utils.gmap('n', '<leader>lw', '<cmd>LspTroubleWorkspaceToggle<CR>',
                     {silent=true, noremap=true})
          utils.gmap('n', '<leader>ld', '<cmd>LspTroubleDocumentToggle<CR>',
                     {silent=true, noremap=true})
        end
      }
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

  use {
    {'tpope/vim-fugitive', cmd={'Git'}},
    {
      'lewis6991/gitsigns.nvim',
      requires={'nvim-lua/plenary.nvim'},
      config=function()
        require('gitsigns').setup({
          signs={
            add={
              hl='GitSignsAdd',
              text='│',
              numhl='GitSignsAddNr',
              linehl='GitSignsAddLn'
            },
            change={
              hl='GitSignsChange',
              text='│',
              numhl='GitSignsChangeNr',
              linehl='GitSignsChangeLn'
            },
            delete={
              hl='GitSignsDelete',
              text='_',
              numhl='GitSignsDeleteNr',
              linehl='GitSignsDeleteLn'
            },
            topdelete={
              hl='GitSignsDelete',
              text='‾',
              numhl='GitSignsDeleteNr',
              linehl='GitSignsDeleteLn'
            },
            changedelete={
              hl='GitSignsChange',
              text='~',
              numhl='GitSignsChangeNr',
              linehl='GitSignsChangeLn'
            }
          },
          signcolumn=true, -- Toggle with `:Gitsigns toggle_signs`
          numhl=false, -- Toggle with `:Gitsigns toggle_numhl`
          linehl=false, -- Toggle with `:Gitsigns toggle_linehl`
          word_diff=false, -- Toggle with `:Gitsigns toggle_word_diff`
          keymaps={
            -- Default keymap options
            noremap=true,

            ['n ]c']={
              expr=true,
              '&diff ? \']c\' : \'<cmd>lua require"gitsigns.actions".next_hunk()<CR>\''
            },
            ['n [c']={
              expr=true,
              '&diff ? \'[c\' : \'<cmd>lua require"gitsigns.actions".prev_hunk()<CR>\''
            },

            ['n <leader>hs']='<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ['v <leader>hs']='<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>hu']='<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ['n <leader>hr']='<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ['v <leader>hr']='<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>hR']='<cmd>lua require"gitsigns".reset_buffer()<CR>',
            ['n <leader>hp']='<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ['n <leader>hb']='<cmd>lua require"gitsigns".blame_line(true)<CR>',
            ['n <leader>hS']='<cmd>lua require"gitsigns".stage_buffer()<CR>',
            ['n <leader>hU']='<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

            -- Text objects
            ['o ih']=':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
            ['x ih']=':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
          },
          sign_priority=6,
          current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
              virt_text = true,
              virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
              delay = 1000,
            },
            current_line_blame_formatter_opts = {
              relative_time = false
            },
        })
      end
    },
    {
      'iberianpig/tig-explorer.vim',
      cmd={'Tig', 'TigStatus'},
      requires='rbgrouleff/bclose.vim'
    },
    {'TimUntersberger/neogit', cmd={'Neogit'}, requires='nvim-lua/plenary.nvim'}
  }

  use {'Shougo/deol.nvim'}

  use {'p00f/nvim-ts-rainbow'}
end)
---}}}
