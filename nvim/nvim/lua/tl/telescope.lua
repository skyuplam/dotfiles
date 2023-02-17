local has_telescope, telescope = pcall(require, 'telescope')

local M = {}

local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local Job = require('plenary.job')

-- Ignore binary files
local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)

  Job:new({
    command='file',
    args={'--mime-type', '-b', filepath},
    on_exit=function(j)
      local mime_types = vim.split(j:result()[1], '/')
      local mime_type = mime_types[1]
      local mime_subtype = mime_types[2]

      if mime_type == 'text' or mime_subtype == 'json' then
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

local delta_file = previewers.new_termopen_previewer {
  get_command=function(entry)
    return {
      'git',
      '-c',
      'core.pager=delta',
      '-c',
      'delta.side-by-side=false',
      'diff',
      '--merge-base',
      vim.fn.expand('$REVIEW_BASE'),
      '--',
      entry.path
    }
  end
}

local delta_commit = previewers.new_termopen_previewer {
  get_command=function(entry)
    return {
      'git',
      '-c',
      'core.pager=delta',
      '-c',
      'delta.side-by-side=false',
      'diff',
      entry.value .. '^!'
    }
  end
}

local function setup()
  if not has_telescope then return end

  telescope.setup({
    defaults={
      layout_strategy='flex',
      layout_config={
        height=.95,
        width=.95,
        flex={flip_columns=120, flip_lines=20},
        horizontal={preview_width=.5},
        vertical={preview_height=.7}
      },
      buffer_previewer_maker=new_maker,
      mappings={
        i={
          ['<C-s>']=actions.cycle_previewers_next,
          ['<C-a>']=actions.cycle_previewers_prev
        }
      },
      history={
        limit=100,
        path=string.format('%s/telescope_history.sqlite3', vim.fn.stdpath 'data')
      }
    },
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

  -- Load plugins
  telescope.load_extension('frecency')
  telescope.load_extension('fzf')
  telescope.load_extension('ui-select')
  telescope.load_extension('live_grep_args')
  telescope.load_extension('file_browser')
  -- telescope.load_extension('dap')
  telescope.load_extension('smart_history')
  telescope.load_extension('notify')
  telescope.load_extension('noice')

  -- Key mappings
  vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end,
                 {desc='Find files'})
  vim.keymap.set('n', '<leader>fg', function()
    require('telescope').extensions.live_grep_args.live_grep_args()
  end, {desc='Live grep files'})
  vim.keymap.set('n', '<leader>fb', function() builtin.buffers() end,
                 {desc='Find buffers'})
  vim.keymap.set('n', '<leader>fh', function() builtin.help_tags() end,
                 {desc='Find help tags'})

  vim.keymap.set('n', '<leader>ft', function() builtin.filetypes() end,
                 {desc='Find filetypes'})
  vim.keymap.set('n', '<leader>fj', function() builtin.jumplist() end,
                 {desc='Find jumplist'})
  vim.keymap.set('n', '<leader>fl', function() builtin.loclist() end,
                 {desc='Find loclist'})
  vim.keymap.set('n', '<leader>fq', function() builtin.quickfix() end,
                 {desc='Find quickfix'})
  vim.keymap.set('n', '<leader>fc', function() builtin.command_history() end,
                 {desc='Find command history'})
  vim.keymap.set('n', '<leader>fs', function() builtin.search_history() end,
                 {desc='Find search history'})

  -- LSP
  vim.keymap.set('n', '<leader>lr', function() builtin.lsp_references() end,
                 {desc='Lsp references'})
  vim.keymap.set('n', '<leader>li',
                 function() builtin.lsp_implementations() end,
                 {desc='Lsp implementations'})
  vim.keymap.set('n', '<leader>ld', function() builtin.lsp_definitions() end,
                 {desc='Lsp definitions'})
  vim.keymap.set('n', '<leader>ly',
                 function() builtin.lsp_type_definitions() end,
                 {desc='Lsp type definitions'})
  vim.keymap.set('n', '<leader>lci',
                 function() builtin.lsp_incoming_calls() end,
                 {desc='Lsp incoming calls'})
  vim.keymap.set('n', '<leader>lco',
                 function() builtin.lsp_outgoing_calls() end,
                 {desc='Lsp outgoing calls'})
  vim.keymap.set('n', '<leader>lD', function() builtin.diagnostics() end,
                 {desc='List current diagnostics', buffer=0})
  vim.keymap.set('n', '<leader>ls',
                 function() builtin.lsp_document_symbols() end,
                 {desc='Lsp document symbols'})

  vim.keymap.set('n', '<leader>gc',
                 function() builtin.git_commits({previewer=delta_commit}) end,
                 {desc='List git commits'})
  vim.keymap.set('n', '<leader>gb', function() builtin.git_branches() end,
                 {desc='List git branchs'})
  vim.keymap.set('n', '<leader>gd', function()
    builtin.git_files({
      prompt_title='Git review files',
      git_command={
        'git',
        'diff',
        '--name-only',
        '--merge-base',
        vim.fn.expand('$REVIEW_BASE')
      },
      previewer=delta_file
    }, {desc='Git review files'})
  end)
  vim.keymap.set('n', '<leader>gf', function() builtin.git_status() end,
                 {desc='Git status'})
  vim.keymap.set('n', '<leader>gp',
                 function() builtin.git_bcommits({previewer=delta_commit}) end,
                 {desc='List buffer commits'})

  vim.keymap.set('n', '<leader>zl', function() builtin.spell_suggest() end,
                 {desc='List spell suggestions'})

  vim.keymap.set('n', '<leader><leader>', function() builtin.resume() end,
                 {desc='Resume'})
  vim.keymap.set('n', '<leader>ee', function()
    require('telescope').extensions.file_browser.file_browser()
  end, {desc='Browser files from root'})
  vim.keymap.set('n', '<leader>eb', function()
    require('telescope').extensions.file_browser.file_browser({
      path='%:p:h',
      select_buffer=true
    })
  end, {desc='Browser files from current file path'})
end

function M.setup() setup(); end

return M
