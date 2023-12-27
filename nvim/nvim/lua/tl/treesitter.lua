local has_config, ts_configs = pcall(require, 'nvim-treesitter.configs')
local has_context, ts_context = pcall(require, 'treesitter-context')

local M = {}

local function setup_ts_config()
  ts_configs.setup({
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'comment',
      'commonlisp',
      'corn',
      'cpp',
      'css',
      'csv',
      'cuda',
      'diff',
      'dockerfile',
      'fennel',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'glsl',
      'go',
      'gomod',
      'gpg',
      'hjson',
      'html',
      'http',
      'ini',
      'javascript',
      'jq',
      'jsdoc',
      'json',
      'json5',
      'llvm',
      'lua',
      'luadoc',
      'luap',
      'make',
      'markdown',
      'markdown_inline',
      'ninja',
      'nix',
      'norg',
      'passwd',
      'proto',
      'python',
      'regex',
      'rst',
      'rust',
      'scss',
      'ssh_config',
      'terraform',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'wgsl',
      'yaml',
      'yuck',
      'zig',
    },
    highlight = { enable = true },
    indent = { enable = true },
    matchup = { enable = true, disable = { 'javascript' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = 'grn',
        scope_incremental = 'grc',
        node_decremental = 'grm',
      },
    },
    refactor = {
      smart_rename = { enable = true, keymaps = { smart_rename = 'grr' } },
      highlight_definitions = { enable = true, clear_on_cursor_move = true },
      highlight_current_scope = { enable = false },
    },
    rainbow = { enable = true, extended_mode = true },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['aC'] = '@class.outer',
          ['iC'] = '@class.inner',
          ['ac'] = '@conditional.outer',
          ['ic'] = '@conditional.inner',
          ['ae'] = '@block.outer',
          ['ie'] = '@block.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['is'] = '@statement.inner',
          ['as'] = '@statement.outer',
          ['ad'] = '@comment.outer',
          ['am'] = '@call.outer',
          ['im'] = '@call.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
    },
  })
end

local function setup_context()
  ts_context.setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        'class',
        'function',
        'method',
        -- 'for', -- These won't appear in the context
        -- 'while',
        -- 'if',
        -- 'switch',
        -- 'case',
      },
      -- Example for a specific filetype.
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      --   rust = {
      --       'impl_item',
      --   },
    },
    exact_patterns = {
      -- Example for a specific filetype with Lua patterns
      -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
      -- exactly match "impl_item" only)
      -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
  })
end

function M.setup()
  if not has_config then
    return
  end
  setup_ts_config()

  if not has_context then
    return
  end
  setup_context()
end

return M
