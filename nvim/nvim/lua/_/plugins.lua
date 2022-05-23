-- vim: set foldmethod=marker foldlevel=0 nomodeline:
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- ============================================================================
--  Bootstrap for packer {{{
-- ============================================================================
-- Note that this will install packer as an opt plugin; if you want packer to be
-- a start plugin, you must modify the value of install_path in the above
-- snippet.
local fn = vim.fn
local packer_bootstrap
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- }}}
-- ============================================================================
--  Plugins {{{
-- ============================================================================

-- Only required if you have packer in your `opt` pack
vim.api.nvim_command('packadd packer.nvim')

-- Global Variable
_G._ = {}

return require('packer').startup(function(use)
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
      {'nvim-treesitter/nvim-treesitter-context', after='nvim-treesitter'},
      config=function() require('_.treesitter').setup() end,
      event='VimEnter *'
    }
  }
  use {'gruvbox-community/gruvbox'}
  use {'vim-jp/syntax-vim-ex'}
  use {
    'lukas-reineke/indent-blankline.nvim',
    config=function() require('_.indent').setup() end
  }

  use {'kevinhwang91/nvim-bqf'}
  use {
    'kyazdani42/nvim-tree.lua',
    requires='kyazdani42/nvim-web-devicons',
    config=function() require('_.nvimtree').setup() end
  }

  use {'Shougo/vimproc.vim', run=':silent! !make'}
  use 'vim-scripts/vis'
  use 'editorconfig/editorconfig-vim'

  use 'mbbill/undotree'

  use 'tpope/vim-rhubarb'
  use 'tpope/vim-sleuth'

  -- use 'ggandor/lightspeed.nvim'

  use 'godlygeek/tabular'

  use {'kamykn/spelunker.vim', requires='kamykn/popup-menu.nvim'}
  use {
    'lewis6991/spellsitter.nvim',
    config=function() require('spellsitter').setup() end
  }

  use 'SirVer/ultisnips'
  use 'hrsh7th/vim-vsnip'

  -- Marks
  use 'kshenoy/vim-signature'
  -- Quickfix
  use {'Olical/vim-enmasse', cmd='EnMasse'}

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  -- use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires={
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run='make'},
      {'nvim-telescope/telescope-ui-select.nvim'}
    },
    config=function() require('_.telescope').setup() end
  }
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

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config=function() require '_.lsp' end,
    requires={
      {'lbrayner/vim-rzip'}, -- https://yarnpkg.com/getting-started/editor-sdks#supporting-go-to-definition-et-al
      {'simrat39/rust-tools.nvim'},
      {'tjdevries/nlua.nvim'},
      -- {'onsails/lspkind-nvim', config=function() require'lspkind'.init() end},
      {'nvim-lua/lsp-status.nvim'},
      {'ray-x/lsp_signature.nvim'},
      {'folke/lsp-colors.nvim'},
      {
        'kosayoda/nvim-lightbulb',
        config=function()
          require('nvim-lightbulb').setup({autocmd={enabled=true}})
        end
      },
      {'b0o/schemastore.nvim'},
      {'j-hui/fidget.nvim', config=function() require('fidget').setup() end},
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

          vim.keymap.set('n', '<leader>lx', '<cmd>TroubleToggle<CR>',
                         {silent=true, noremap=true})
          vim.keymap.set('n', '<leader>lw',
                         '<cmd>TroubleToggle workspace_diagnostics<CR>',
                         {silent=true, noremap=true})
          vim.keymap.set('n', '<leader>ld',
                         '<cmd>TroubleToggle document_diagnostics<CR>',
                         {silent=true, noremap=true})
        end
      }
    }
  }

  use {
    'hrsh7th/nvim-cmp',
    requires={
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'petertriho/cmp-git',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-cmdline',
      'dmitmel/cmp-cmdline-history',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-vsnip',
      'andersevenrud/cmp-tmux',
      'onsails/lspkind-nvim'
    }
  }

  use {
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
          watch_gitdir={interval=1000, follow_files=true},
          attach_to_untracked=true,

          on_attach=function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gs.next_hunk() end)
              return '<Ignore>'
            end, {expr=true})

            map('n', '[c', function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gs.prev_hunk() end)
              return '<Ignore>'
            end, {expr=true})

            -- Actions
            map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)
            map('n', '<leader>hb', function()
              gs.blame_line {full=true}
            end)
            map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hD', function() gs.diffthis('~') end)
            map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end,
          current_line_blame=true, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts={
            virt_text=true,
            virt_text_pos='eol', -- 'eol' | 'overlay' | 'right_align'
            delay=1000,
            ignore_whitespace=false
          },
          current_line_blame_formatter='<author>, <author_time:%Y-%m-%d> - <summary>',
          sign_priority=6,
          update_debounce=100,
          status_formatter=nil, -- Use default
          max_file_length=40000,
          preview_config={
            -- Options passed to nvim_open_win
            border='single',
            style='minimal',
            relative='cursor',
            row=0,
            col=1
          },
          yadm={enable=false}
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

  -- configure Neovim to automatically run :PackerCompile whenever plugins.lua is updated
  local packer_au_group = vim.api.nvim_create_augroup('packer_au_group',
                                                      {clear=true})
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern='plugins.lua',
    group=packer_au_group,
    command='source <afile> | PackerCompile'
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then require('packer').sync() end
end)
---}}}
