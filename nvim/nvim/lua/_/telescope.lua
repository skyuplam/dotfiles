local has_telescope, telescope = pcall(require, 'telescope')

if not has_telescope then return end

local M = {}

local function setup()

  telescope.setup({
    extensions={
      fzf={
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
      }
    }
  })

  telescope.load_extension('fzf')
  telescope.load_extension('ui-select')

  -- Key mappings
  vim.keymap.set('n', '<leader>ff',
                 function() require('telescope.builtin').find_files() end)
  vim.keymap.set('n', '<leader>fg',
                 function() require('telescope.builtin').live_grep() end)
  vim.keymap.set('n', '<leader>fb',
                 function() require('telescope.builtin').buffers() end)
  vim.keymap.set('n', '<leader>fh',
                 function() require('telescope.builtin').help_tags() end)

  vim.keymap.set('n', '<leader>gc',
                 function() require('telescope.builtin').git_commits() end)
  vim.keymap.set('n', '<leader>gb',
                 function() require('telescope.builtin').git_branches() end)
  vim.keymap.set('n', '<leader>gf',
                 function() require('telescope.builtin').git_status() end)
  vim.keymap.set('n', '<leader>gp',
                 function() require('telescope.builtin').git_bcommits() end)
  vim.keymap.set('n', '<leader>wo', function()
    require('telescope.builtin').lsp_document_symbols()
  end)
end

function M.setup() setup() end

return M
