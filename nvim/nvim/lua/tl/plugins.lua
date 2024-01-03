-- vim: set foldmethod=marker foldlevel=0 nomodeline:
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- ============================================================================
--  Plugins {{{
-- ============================================================================
return require('lazy').setup({
  {
    'tpope/vim-dispatch',
    lazy = true,
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
  },
  { 'sheerun/vim-polyglot' },
  { 'elkowar/yuck.vim' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({
        with_sync = true,
      })
      ts_update()
    end,
    config = function()
      require('tl.treesitter').setup()
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-refactor' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/nvim-treesitter-context' },
    },
  },
  { 'folke/tokyonight.nvim', lazy = false, priority = 1000, opts = {} },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufReadPost',
    opts = {},

    init = function()
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', function()
        require('ufo').openAllFolds()
      end)
      vim.keymap.set('n', 'zM', function()
        require('ufo').closeAllFolds()
      end)
    end,
    config = function()
      require('ufo').setup()
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  { 'vim-jp/syntax-vim-ex' },
  {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  { 'kevinhwang91/nvim-bqf' },

  { 'Shougo/vimproc.vim', build = ':silent! !make' },
  { 'vim-scripts/vis' },
  { 'editorconfig/editorconfig-vim' },

  { 'mbbill/undotree' },

  { 'tpope/vim-rhubarb' },

  -- Neovim setup for init.lua and plugin development with full signature help,
  -- docs and completion for the nvim lua API
  { 'folke/neodev.nvim' },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup()

      local map = require('tl.common').map
      -- Extract block supports only normal mode
      map({ 'n', 'x' }, '<leader>rr', function()
        require('refactoring').select_refactor()
      end)
    end,
  },

  { 'godlygeek/tabular' },

  { 'kamykn/spelunker.vim' },

  -- Marks
  -- Quickfix
  { 'Olical/vim-enmasse', cmd = 'EnMasse' },

  { 'tpope/vim-repeat' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = { 'tami5/sqlite.lua' },
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      {
        'nvim-telescope/telescope-smart-history.nvim',
        dependencies = { 'tami5/sqlite.lua' },
      },
      {
        'nvim-telescope/telescope-media-files.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'nvim-lua/popup.nvim',
        },
      },
    },
    config = function()
      require('tl.telescope').setup()
    end,
  },
  { 'ryanoasis/vim-devicons' },

  {
    dir = '~/dev/vim-redact-pass',
    event = 'VimEnter /private$TMPDIR/pass.?*/?*.txt,/dev/shm/pass.?*/?*.txt',
  },

  -- Clipboard manager
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('neoclip').setup()
    end,
  },

  { 'junegunn/vim-slash' },
  { 'junegunn/gv.vim' },
  { 'junegunn/vim-peekaboo' },
  { 'junegunn/vim-easy-align' },

  { 'vim-scripts/utl.vim' },
  { 'majutsushi/tagbar' },
  { 'tpope/vim-speeddating' },
  { 'chrisbra/NrrwRgn' },
  { 'mattn/calendar-vim' },
  { 'inkarkat/vim-SyntaxRange' },

  {
    'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup({
        disable_float_win = true,
        priority = 100,
        autostart = true,
        threshold = 1,
        speed = 30,
        type = 'default',
        intervals = 50,
        fancy = {
          enable = true,
          head = { cursor = '', texthl = 'SmoothCursor' },
          body = {
            { cursor = '●', texthl = 'SmoothCursorBody' },
            { cursor = '●', texthl = 'SmoothCursorBody' },
            { cursor = '•', texthl = 'SmoothCursorBody' },
            { cursor = '•', texthl = 'SmoothCursorBody' },
            { cursor = '∙', texthl = 'SmoothCursorBody' },
            { cursor = '∙', texthl = 'SmoothCursorBody' },
          },
        },
      })

      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup('CursorModeChangeGroup', {})

      vim.api.nvim_clear_autocmds({ group = augroup })
      autocmd({ 'ModeChanged' }, {
        group = augroup,
        callback = function()
          local current_mode = vim.fn.mode()
          if current_mode == 'n' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
            vim.api.nvim_set_hl(0, 'SmoothCursorBody', { fg = '#8aa872' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          elseif current_mode == 'v' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.api.nvim_set_hl(0, 'SmoothCursorBody', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          elseif current_mode == 'V' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.api.nvim_set_hl(0, 'SmoothCursorBody', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          elseif current_mode == '' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.api.nvim_set_hl(0, 'SmoothCursorBody', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          elseif current_mode == 'i' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
            vim.api.nvim_set_hl(0, 'SmoothCursorBoby', { fg = '#668aab' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          end
        end,
      })
    end,
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup({})
      require('mini.align').setup({})
      require('mini.surround').setup({})
      require('mini.bufremove').setup({})
      require('mini.cursorword').setup({})
      require('mini.indentscope').setup({
        draw = {
          delay = 0,
          animation = require('mini.indentscope').gen_animation.none(),
        },
      })
      require('mini.misc').setup({ make_global = { 'zoom' } })
      require('tl.common').map(
        'n',
        '<leader>zz',
        zoom,
        { desc = 'Toggle zoom current buffer' }
      )
    end,
  },

  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      {
        '<leader>sr',
        function()
          require('spectre').open()
        end,
        desc = 'Replace in files (Spectre)',
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- Color tool
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ 'css', 'html', 'typescript' })
    end,
  },

  -- Snippets
  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
        dependencies = { 'rafamadriz/friendly-snippets' },
        build = 'make install_jsregexp',
      },
      {
        'numToStr/Comment.nvim',
        opts = {},
      },
    },
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      notify.setup()
      vim.notify = notify
    end,
  },

  {
    'Exafunction/codeium.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('codeium').setup({})
    end,
  },

  {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neorg/neorg-telescope',
    },
    config = function()
      require('neorg').setup({
        load = {
          ['core.esupports.metagen'] = {
            config = { type = 'auto', update_date = true },
          },
          ['core.defaults'] = {}, -- Loads default behaviour
          ['core.concealer'] = {}, -- Adds pretty icons to your documents
          ['core.completion'] = { config = { engine = 'nvim-cmp' } }, -- Adds pretty icons to your documents
          ['core.ui.calendar'] = {}, -- Adds pretty icons to your documents
          ['core.dirman'] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = '~/notes/home',
              },
              default_workspace = 'notes',
            },
          },
          ['core.journal'] = {
            config = { strategy = 'flat', workspace = 'notes' },
          }, -- Adds pretty icons to your documents
          ['core.integrations.telescope'] = {},
          ['core.keybinds'] = {
            config = {
              hook = function(keybinds)
                -- Map all the below keybinds only when the "norg" mode is active
                keybinds.map_event_to_mode('norg', {
                  n = { -- Bind keys in normal mode
                    {
                      '<C-s>',
                      'core.integrations.telescope.find_linkable',
                      opts = { desc = 'Find Linkable' },
                    },
                  },
                  i = { -- Bind in insert mode
                    {
                      '<C-l>',
                      'core.integrations.telescope.insert_link',
                      opts = { desc = 'Insert Link' },
                    },
                  },
                }, {
                  silent = true,
                  noremap = true,
                })
              end,
            },
          },
        },
      })
      -- temp workaround for ft issue
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { '*.norg' },
        callback = function()
          vim.opt.ft = 'norg'
        end,
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('tl.lsp')
    end,
    dependencies = {
      { 'lbrayner/vim-rzip' }, -- https://yarnpkg.com/getting-started/editor-sdks#supporting-go-to-definition-et-al
      { 'simrat39/rust-tools.nvim' },
      -- {'onsails/lspkind-nvim', config=function() require'lspkind'.init() end},
      { 'ray-x/lsp_signature.nvim' },
      { 'folke/lsp-colors.nvim' },
      { 'b0o/schemastore.nvim' },
      { 'p00f/clangd_extensions.nvim' },
      {
        'VidocqH/lsp-lens.nvim',
        config = function()
          require('lsp-lens').setup({})
        end,
      },
      {
        'smjonas/inc-rename.nvim',
        config = function()
          require('inc_rename').setup()
        end,
      },
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup()
        end,
        tag = 'legacy',
      },
      {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
          require('trouble').setup({})
        end,
      },
      {
        'simrat39/symbols-outline.nvim',
        keys = {
          { '<leader>cs', '<cmd>SymbolsOutline<cr>', desc = 'Symbols Outline' },
        },
        cmd = 'SymbolsOutline',
        opts = {},
      },
    },
  },

  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'petertriho/cmp-git',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'andersevenrud/cmp-tmux',
      'ray-x/cmp-treesitter',
      'onsails/lspkind-nvim',
      'dmitmel/cmp-cmdline-history',
      'f3fora/cmp-spell',
      'lukas-reineke/cmp-rg',
    },
  },

  {
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup({
          signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
          numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
          linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
          _threaded_diff = true, -- Run diffs on a separate thread
          _extmark_signs = true, -- Use extmarks for placing signs
          word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
          watch_gitdir = { interval = 1000, follow_files = true },
          attach_to_untracked = true,

          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local map = require('tl.common').map

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then
                return ']c'
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return '<Ignore>'
            end, {
              expr = true,
              buffer = bufnr,
              desc = 'Git next hunk',
            })

            map('n', '[c', function()
              if vim.wo.diff then
                return '[c'
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return '<Ignore>'
            end, {
              expr = true,
              buffer = bufnr,
              desc = 'Git prev hunk',
            })

            -- Actions
            map(
              { 'n', 'v' },
              '<leader>hs',
              ':Gitsigns stage_hunk<CR>',
              { buffer = bufnr, desc = 'Git stage hunk' }
            )
            map(
              { 'n', 'v' },
              '<leader>hr',
              ':Gitsigns reset_hunk<CR>',
              { buffer = bufnr, desc = 'Git reset hunk' }
            )
            map(
              'n',
              '<leader>hS',
              gs.stage_buffer,
              { buffer = bufnr, desc = 'Git stage buffer' }
            )
            map(
              'n',
              '<leader>hu',
              gs.undo_stage_hunk,
              { buffer = bufnr, desc = 'Git undo stage hunk' }
            )
            map(
              'n',
              '<leader>hR',
              gs.reset_buffer,
              { buffer = bufnr, desc = 'Git reset buffer' }
            )
            map(
              'n',
              '<leader>hp',
              gs.preview_hunk,
              { buffer = bufnr, desc = 'Git preview hunk' }
            )
            map('n', '<leader>hb', function()
              gs.blame_line({ full = true })
            end, { buffer = bufnr, desc = 'Git blame line full' })
            map('n', '<leader>tb', gs.toggle_current_line_blame, {
              buffer = bufnr,
              desc = 'Git toggle current line blame',
            })
            map('n', '<leader>hd', gs.diffthis, {
              buffer = bufnr,
              desc = 'Git diffthis against the index',
            })
            map('n', '<leader>hD', function()
              gs.diffthis('~')
            end, {
              buffer = bufnr,
              desc = 'Git diffthis against the last commit',
            })
            map(
              'n',
              '<leader>td',
              gs.toggle_deleted,
              { buffer = bufnr, desc = 'Git toggle show deleted' }
            )

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end,
          current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
          },
          current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
          sign_priority = 6,
          update_debounce = 100,
          status_formatter = nil, -- Use default
          max_file_length = 40000,
          preview_config = {
            -- Options passed to nvim_open_win
            border = tl.style.current.border,
          },
          yadm = { enable = false },
        })
      end,
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  },

  -- Terminal filemanager
  {
    'Rolv-Apneseth/tfm.nvim',
    opts = {},
    config = function()
      local map = require('tl.common').map
      local tfm = require('tfm')
      tfm.setup({
        ui = {
          border = 'rounded',
          height = 1,
          width = 1,
          x = 0.5,
          y = 0.5,
        },
      })
      -- Set keymap so you can open the default terminal file manager (yazi)
      map('n', '<C-e>', tfm.open, {
        noremap = true,
        desc = 'Open Yazi',
      })
    end,
  },

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('tl.term').setup()
    end,
  },

  -- Build a statusline
  {
    'rebelot/heirline.nvim',
    config = function()
      require('tl.statusline').setup()
    end,
    dependencies = {
      'SmiteshP/nvim-navic',
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
      'folke/tokyonight.nvim',
    },
  },
  {
    'allaman/kustomize.nvim',
    requires = 'nvim-lua/plenary.nvim',
    ft = 'yaml',
    config = true,
  },
  {
    'AckslD/nvim-FeMaco.lua',
    config = function()
      require('femaco').setup()
    end,
  },
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
})
---}}}
