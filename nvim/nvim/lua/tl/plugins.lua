-- vim: set foldmethod=marker foldlevel=0 nomodeline:
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- ============================================================================
--  Plugins {{{
-- ============================================================================
return require('packer').startup(function(use)
    -- use 'lewis6991/impatient.nvim'
    use {'wbthomason/packer.nvim'}

    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }
    use {'andymass/vim-matchup', event = 'VimEnter *'}

    use {'sheerun/vim-polyglot'}
    use {'elkowar/yuck.vim'}
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end,
        config = function() require('tl.treesitter').setup() end,
        requires = {
            {
                'nvim-treesitter/nvim-treesitter-refactor',
                after = 'nvim-treesitter'
            },
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                after = 'nvim-treesitter'
            },
            {
                'nvim-treesitter/nvim-treesitter-context',
                after = 'nvim-treesitter'
            }
        }
    }
    use {'folke/tokyonight.nvim'}
    use {
        'folke/which-key.nvim',
        config = function() require('tl.keys').setup(); end
    }
    use {'vim-jp/syntax-vim-ex'}

    -- use {'eraserhd/parinfer-rust', run='cargo build --release'}

    use {
        'danymat/neogen',
        config = function()
            require('neogen').setup({
                languages = {
                    typescript = {template = {annotation_convention = 'tsdoc'}},
                    typescriptreact = {
                        template = {annotation_convention = 'tsdoc'}
                    }
                }
            })
        end,
        requires = 'nvim-treesitter/nvim-treesitter'
    }
    use {'m-demare/hlargs.nvim', requires = {'nvim-treesitter/nvim-treesitter'}}

    use {'kevinhwang91/nvim-bqf'}
    -- use {
    --   'kyazdani42/nvim-tree.lua',
    --   config=function() require('tl.nvimtree').setup() end,
    --   requires='kyazdani42/nvim-web-devicons'
    -- }
    use {'is0n/fm-nvim'}

    use {'Shougo/vimproc.vim', run = ':silent! !make'}
    use 'vim-scripts/vis'
    use 'editorconfig/editorconfig-vim'

    use 'mbbill/undotree'

    use 'tpope/vim-rhubarb'
    use 'tpope/vim-sleuth'

    -- Neovim setup for init.lua and plugin development with full signature help,
    -- docs and completion for the nvim lua API
    use {'folke/neodev.nvim'}

    use 'godlygeek/tabular'

    use {'kamykn/spelunker.vim'}
    use {
        'lewis6991/spellsitter.nvim',
        config = function() require('spellsitter').setup() end
    }

    -- Marks
    use 'kshenoy/vim-signature'
    -- Quickfix
    use {'Olical/vim-enmasse', cmd = 'EnMasse'}

    use 'tpope/vim-repeat'
    -- use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
            {
                'nvim-telescope/telescope-frecency.nvim',
                requires = {'tami5/sqlite.lua'}
            }, {'nvim-telescope/telescope-ui-select.nvim'},
            {'nvim-telescope/telescope-file-browser.nvim'},
            -- {'nvim-telescope/telescope-dap.nvim'},
            {'nvim-telescope/telescope-live-grep-args.nvim'}, {
                'nvim-telescope/telescope-smart-history.nvim',
                requires = {'tami5/sqlite.lua'}
            }
        },
        config = function() require('tl.telescope').setup() end
    }
    use 'ryanoasis/vim-devicons'
    -- use {
    --   'norcalli/nvim-colorizer.lua',
    --   config=function() require('colorizer').setup() end
    -- }

    use {
        '~/dev/vim-redact-pass',
        event = 'VimEnter /private$TMPDIR/pass.?*/?*.txt,/dev/shm/pass.?*/?*.txt'
    }

    -- use {
    --   'mhartington/formatter.nvim',
    --   config=function() require('tl.formatter').setup() end
    -- }

    use 'junegunn/vim-slash'
    use 'junegunn/gv.vim'
    use 'junegunn/vim-peekaboo'
    use 'junegunn/vim-easy-align'

    use 'vim-scripts/utl.vim'
    use 'majutsushi/tagbar'
    use 'tpope/vim-speeddating'
    use 'chrisbra/NrrwRgn'
    use 'mattn/calendar-vim'
    use 'inkarkat/vim-SyntaxRange'

    use {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup({})
            require('mini.align').setup({})
            require('mini.surround').setup({})
            require('mini.bufremove').setup({})
            require('mini.comment').setup({})
            require('mini.cursorword').setup({})
            require('mini.indentscope').setup({
                draw = {
                    delay = 0,
                    animation = require('mini.indentscope').gen_animation.none()
                }
            })
            require('mini.misc').setup({make_global = {'zoom'}})
            require('tl.common').map('n', '<leader>zz', zoom,
                                     {desc = 'Toggle zoom current buffer'})
        end
    }

    use({
        'folke/noice.nvim',
        config = function() require('tl.noice').setup() end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim', -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            {
                'rcarriga/nvim-notify',
                config = function()
                    require('notify').setup({background_colour = '#000000'})
                end
            }
        }
    })

    -- Color tool
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({'css', 'html', 'typescript'})
        end
    }

    -- Snippets
    use {
        'saadparwaiz1/cmp_luasnip',
        requires = {{'L3MON4D3/LuaSnip', tag = 'v1.*'}}
    }

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = function() require 'tl.lsp' end,
        requires = {
            {'lbrayner/vim-rzip'}, -- https://yarnpkg.com/getting-started/editor-sdks#supporting-go-to-definition-et-al
            {'simrat39/rust-tools.nvim'},
            -- {'onsails/lspkind-nvim', config=function() require'lspkind'.init() end},
            {'ray-x/lsp_signature.nvim'}, {'folke/lsp-colors.nvim'},
            {'b0o/schemastore.nvim'},
            {
                'j-hui/fidget.nvim',
                config = function() require('fidget').setup() end
            }, {
                'folke/trouble.nvim',
                requires = 'kyazdani42/nvim-web-devicons',
                config = function() require('trouble').setup({}) end
            }
        }
    }

    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- Interactive Repls Over Neovim
    use {
        'hkupty/iron.nvim',
        commands = {'IronRepl', 'IronSend', 'IronReplHere'},
        loaded = false,
        needs_bufread = false,
        only_cond = false,
        config = function()
            require('iron.core').setup({
                config = {
                    highlight_last = 'IronLastSent',
                    -- If iron should expose `<plug>(...)` mappings for the plugins
                    -- Whether a repl should be discarded or not
                    scratch_repl = true,
                    -- Your repl definitions come here
                    repl_definition = {sh = {command = {'zsh'}}}
                },
                keymaps = {
                    send_motion = '<leader>sc',
                    visual_send = '<leader>sc'
                }
            })
        end
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help', 'petertriho/cmp-git',
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua', 'andersevenrud/cmp-tmux',
            'onsails/lspkind-nvim', 'dmitmel/cmp-cmdline-history',
            'f3fora/cmp-spell', 'lukas-reineke/cmp-rg'
        }
    }

    use {
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
                    watch_gitdir = {interval = 1000, follow_files = true},
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
                            desc = 'Git next hunk'
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
                            desc = 'Git prev hunk'
                        })

                        -- Actions
                        map({'n', 'v'}, '<leader>hs',
                            ':Gitsigns stage_hunk<CR>',
                            {buffer = bufnr, desc = 'Git stage hunk'})
                        map({'n', 'v'}, '<leader>hr',
                            ':Gitsigns reset_hunk<CR>',
                            {buffer = bufnr, desc = 'Git reset hunk'})
                        map('n', '<leader>hS', gs.stage_buffer,
                            {buffer = bufnr, desc = 'Git stage buffer'})
                        map('n', '<leader>hu', gs.undo_stage_hunk,
                            {buffer = bufnr, desc = 'Git undo stage hunk'})
                        map('n', '<leader>hR', gs.reset_buffer,
                            {buffer = bufnr, desc = 'Git reset buffer'})
                        map('n', '<leader>hp', gs.preview_hunk,
                            {buffer = bufnr, desc = 'Git preview hunk'})
                        map('n', '<leader>hb',
                            function()
                            gs.blame_line {full = true}
                        end, {buffer = bufnr, desc = 'Git blame line full'})
                        map('n', '<leader>tb', gs.toggle_current_line_blame, {
                            buffer = bufnr,
                            desc = 'Git toggle current line blame'
                        })
                        map('n', '<leader>hd', gs.diffthis, {
                            buffer = bufnr,
                            desc = 'Git diffthis against the index'
                        })
                        map('n', '<leader>hD', function()
                            gs.diffthis('~')
                        end, {
                            buffer = bufnr,
                            desc = 'Git diffthis against the last commit'
                        })
                        map('n', '<leader>td', gs.toggle_deleted,
                            {buffer = bufnr, desc = 'Git toggle show deleted'})

                        -- Text object
                        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                    end,
                    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                    current_line_blame_opts = {
                        virt_text = true,
                        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                        delay = 1000,
                        ignore_whitespace = false
                    },
                    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                    sign_priority = 6,
                    update_debounce = 100,
                    status_formatter = nil, -- Use default
                    max_file_length = 40000,
                    preview_config = {
                        -- Options passed to nvim_open_win
                        border = tl.style.current.border
                    },
                    yadm = {enable = false}
                })
            end,
            requires = {'nvim-lua/plenary.nvim'}
        }, {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}
    }

    -- use {'Shougo/deol.nvim'}

    use {
        'akinsho/toggleterm.nvim',
        tag = '*',
        config = function() require('tl.term').setup() end
    }

    -- Build a statusline
    use {
        'rebelot/heirline.nvim',
        config = function() require('tl.statusline').setup() end,
        requires = {
            'SmiteshP/nvim-navic', 'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons', 'folke/tokyonight.nvim'
        }
    }

    use {'AckslD/nvim-FeMaco.lua', config = 'require("femaco").setup()'}
end)
---}}}
