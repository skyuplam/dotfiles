local has_telescope, telescope = pcall(require, 'telescope')

local M = {}

local previewers = require('telescope.previewers')
local Job = require('plenary.job')

-- Ignore binary files
local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)

  Job:new({
    command='file',
    args={'--mime-type', '-b', filepath},
    on_exit=function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]

      if mime_type == 'text' then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {'BINARY'})
        end)
      end
    end
  }):sync()
end

local function setup()
  if not has_telescope then return end

  telescope.setup({
    defaults={layout_strategy='flex', buffer_previewer_maker=new_maker},
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
      },
      file_browser={
        theme='ivy',
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw=true,
        mappings={
          ['i']={
            -- your custom insert mode mappings
          },
          ['n']={
            -- your custom normal mode mappings
          }
        }
      }
    }
  })

  telescope.load_extension('frecency')
  telescope.load_extension('fzf')
  telescope.load_extension('ui-select')
  telescope.load_extension('live_grep_args')
  telescope.load_extension('file_browser')

  -- Key mappings
  vim.keymap.set('n', '<leader>ff',
                 function() require('telescope.builtin').find_files() end)
  vim.keymap.set('n', '<leader>fg', function()
    require('telescope').extensions.live_grep_args.live_grep_args()
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
  vim.keymap.set('n', '<leader>ee', function()
    require('telescope').extensions.file_browser.file_browser()
  end)
  vim.keymap.set('n', '<leader>eb', function()
    require('telescope').extensions.file_browser.file_browser({
      path='%:p:h',
      select_buffer=true
    })
  end)
end

function M.setup() setup() end

return M
