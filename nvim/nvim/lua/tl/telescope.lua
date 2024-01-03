local has_telescope, telescope = pcall(require, 'telescope')

local M = {}

-- local Job = require('plenary.job')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')
local map = require('tl.common').map

-- Ignore binary files
-- local new_maker = function(filepath, bufnr, opts)
--   opts = opts or {}
--
--   filepath = vim.fn.expand(filepath)
--
--   Job:new({
--     command = 'file',
--     args = { '--mime-type', '-b', filepath },
--     on_exit = function(j)
--       local mime_types = vim.split(j:result()[1], '/')
--       local mime_type = mime_types[1]
--       local mime_subtype = mime_types[2]
--
--       if mime_type == 'text' or mime_subtype == 'json' then
--         previewers.buffer_previewer_maker(filepath, bufnr, opts)
--       else
--         -- maybe we want to write something to the buffer here
--         vim.schedule(function()
--           vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
--         end)
--       end
--     end,
--   }):sync()
-- end

local delta_file = previewers.new_termopen_previewer({
  get_command = function(entry)
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
      entry.path,
    }
  end,
})

local delta_commit = previewers.new_termopen_previewer({
  get_command = function(entry)
    return {
      'git',
      '-c',
      'core.pager=delta',
      '-c',
      'delta.side-by-side=false',
      'diff',
      entry.value .. '^!',
    }
  end,
})

local function setup()
  if not has_telescope then
    return
  end

  telescope.setup({
    defaults = {
      layout_strategy = 'flex',
      layout_config = {
        height = 0.95,
        width = 0.95,
        flex = { flip_columns = 220, flip_lines = 20 },
        horizontal = { preview_width = 0.5 },
        vertical = { preview_height = 0.7 },
      },
      -- buffer_previewer_maker = new_maker,
      mappings = {
        i = {
          ['<C-s>'] = actions.cycle_previewers_next,
          ['<C-a>'] = actions.cycle_previewers_prev,
        },
      },
      history = {
        limit = 100,
        path = string.format(
          '%s/telescope_history.sqlite3',
          vim.fn.stdpath('data')
        ),
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      ['ui-select'] = {

        require('telescope.themes').get_dropdown({
          -- even more opts
        }),

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
      frecency = {},
      live_grep_raw = {
        auto_quoting = true, -- enable/disable auto-quoting
      },
      media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
        -- find command (defaults to `fd`)
        find_cmd = 'rg',
      },
    },
  })

  -- Load plugins
  telescope.load_extension('frecency')
  telescope.load_extension('fzf')
  telescope.load_extension('ui-select')
  telescope.load_extension('live_grep_args')
  -- telescope.load_extension('dap')
  telescope.load_extension('smart_history')
  telescope.load_extension('neoclip')
  telescope.load_extension('media_files')

  -- Key mappings
  map('n', '<leader>ff', function()
    builtin.find_files()
  end, { desc = 'Find files' })
  map('n', '<leader>fg', function()
    require('telescope').extensions.live_grep_args.live_grep_args()
  end, { desc = 'Live grep files' })
  map('n', '<leader>fb', function()
    builtin.buffers()
  end, { desc = 'Find buffers' })
  map('n', '<leader>fh', function()
    builtin.help_tags()
  end, { desc = 'Find help tags' })
  map('n', '<leader>f"', function()
    require('telescope').extensions.neoclip.default()
  end, { desc = 'Find register "' })

  map('n', '<leader>ft', function()
    builtin.filetypes()
  end, { desc = 'Find filetypes' })
  map('n', '<leader>fj', function()
    builtin.jumplist()
  end, { desc = 'Find jumplist' })
  map('n', '<leader>fl', function()
    builtin.loclist()
  end, { desc = 'Find loclist' })
  map('n', '<leader>fq', function()
    builtin.quickfix()
  end, { desc = 'Find quickfix' })
  map('n', '<leader>fc', function()
    builtin.command_history()
  end, { desc = 'Find command history' })
  map('n', '<leader>fs', function()
    builtin.search_history()
  end, { desc = 'Find search history' })

  -- LSP
  map('n', '<leader>lr', function()
    builtin.lsp_references()
  end, { desc = 'Lsp references' })
  map('n', '<leader>li', function()
    builtin.lsp_implemencations()
  end, { desc = 'Lsp implementations' })
  map('n', '<leader>ld', function()
    builtin.lsp_definitions()
  end, { desc = 'Lsp definitions' })
  map('n', '<leader>ly', function()
    builtin.lsp_type_definitions()
  end, { desc = 'Lsp type definitions' })
  map('n', '<leader>lci', function()
    builtin.lsp_incoming_calls()
  end, { desc = 'Lsp incoming calls' })
  map('n', '<leader>lco', function()
    builtin.lsp_outgoing_calls()
  end, { desc = 'Lsp outgoing calls' })
  map('n', '<leader>lD', function()
    builtin.diagnostics()
  end, { desc = 'List diagnostics' })
  map('n', '<leader>ls', function()
    builtin.lsp_document_symbols()
  end, { desc = 'Lsp document symbols' })

  map('n', '<leader>gc', function()
    builtin.git_commits({ previewer = delta_commit })
  end, { desc = 'List git commits' })
  map('n', '<leader>gb', function()
    builtin.git_branches()
  end, { desc = 'List git branches' })
  map('n', '<leader>gd', function()
    builtin.git_files({
      prompt_title = 'Git review files',
      git_command = {
        'git',
        'diff',
        '--name-only',
        '--merge-base',
        vim.fn.expand('$REVIEW_BASE'),
      },
      previewer = delta_file,
    })
  end, { desc = 'Git review files' })
  -- map('n', '<leader>gd', function()
  --   require('telescope').extensions.git_diffs.diff_commits()
  -- end, { desc = 'Git diff commits' })
  map('n', '<leader>gf', function()
    builtin.git_status()
  end, { desc = 'Git status' })
  map('n', '<leader>gp', function()
    builtin.git_bcommits({ previewer = delta_commit })
  end, { desc = 'List buffer commits' })
  map('v', '<leader>gp', function()
    builtin.git_bcommits_range({ operator = true })
  end, { desc = 'List buffer commits for selected' })

  map('n', '<leader>zl', function()
    builtin.spell_suggest()
  end, { desc = 'List spell suggestions' })

  map('n', '<leader><leader>', function()
    builtin.resume()
  end, { desc = 'Resume' })
end

function M.setup()
  setup()
end

return M
