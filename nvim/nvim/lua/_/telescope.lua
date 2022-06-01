local has_telescope, telescope = pcall(require, 'telescope')

if not has_telescope then return end

local M = {}

local function setup()

  telescope.setup({
    defaults={layout_strategy='flex'},
    extensions={
      fzf={
        fuzzy=true,
        override_generic_sorter=true, -- override the generic sorter
        override_file_sorter=true, -- override the file sorter
        case_mode='smart_case' -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      ['ui-select']={

        require('telescope.themes').get_dropdown {
          -- even more opts
        }

        -- pseudo code / specification for writing custom displays, like the one
        -- for "codeactions"
        -- specific_opts = {
        --   [kind] = {
        --     make_indexed = function(items) -> indexed_items, width,
        --     make_displayer = function(widths) -> displayer
        --     make_display = function(displayer) -> function(e)
        --     make_ordinal = function(e) -> string
        --   },
        --   -- for example to disable the custom builtin "codeactions" display
        --      do the following
        --   codeactions = false,
        -- }
      },
      frecency={},
      live_grep_raw={
        auto_quoting=true -- enable/disable auto-quoting
      }
    }
  })

  telescope.load_extension('frecency')
  telescope.load_extension('fzf')
  telescope.load_extension('ui-select')
  telescope.load_extension('live_grep_raw')

  -- Key mappings
  vim.keymap.set('n', '<leader>ff',
                 function() require('telescope.builtin').find_files() end)
  vim.keymap.set('n', '<leader>fg', function()
    require('telescope').extensions.live_grep_raw.live_grep_raw()
  end)
  vim.keymap.set('n', '<leader>fb',
                 function() require('telescope.builtin').buffers() end)
  vim.keymap.set('n', '<leader>fh',
                 function() require('telescope.builtin').help_tags() end)

  vim.keymap.set('n', '<leader>ft',
                 function() require('telescope.builtin').filetypes() end)
  vim.keymap.set('n', '<leader>fj',
                 function() require('telescope.builtin').jumplist() end)
  vim.keymap.set('n', '<leader>fl',
                 function() require('telescope.builtin').loclist() end)
  vim.keymap.set('n', '<leader>fq',
                 function() require('telescope.builtin').quickfix() end)
  vim.keymap.set('n', '<leader>fc',
                 function() require('telescope.builtin').command_history() end)
  vim.keymap.set('n', '<leader>fs',
                 function() require('telescope.builtin').search_history() end)

  vim.keymap.set('n', '<leader>gc',
                 function() require('telescope.builtin').git_commits() end)
  vim.keymap.set('n', '<leader>gb',
                 function() require('telescope.builtin').git_branches() end)
  vim.keymap.set('n', '<leader>gf',
                 function() require('telescope.builtin').git_status() end)
  vim.keymap.set('n', '<leader>gp',
                 function() require('telescope.builtin').git_bcommits() end)

  vim.keymap.set('n', '<leader>zl',
                 function() require('telescope.builtin').spell_suggest() end)

  vim.keymap.set('n', '<leader><leader>',
                 function() require('telescope.builtin').resume() end)
end

function M.setup() setup() end

return M
