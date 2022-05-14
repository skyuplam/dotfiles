local has_telescope, telescope = pcall(require, 'telescope')

if not has_telescope then return end

local M = {}

local function setup()

  telescope.setup({
    extensions={
      fzy={
        override_generic_sorter=true, -- override the generic sorter
        override_file_sorter=true, -- override the file sorter
        case_mode='smart_case' -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  })

  telescope.load_extension('fzy_native')

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
