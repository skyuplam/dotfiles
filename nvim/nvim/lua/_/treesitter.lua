local has_config, ts_configs = pcall(require, 'nvim-treesitter.configs')

if not has_config then return end

ts_configs.setup {
  ensure_installed={
    'bash',
    'c',
    'cmake',
    'comment',
    'commonlisp',
    'cpp',
    'css',
    'dockerfile',
    'fennel',
    'fish',
    'go',
    'gomod',
    'haskell',
    'help',
    'hjson',
    'html',
    'http',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'JSON',
    'llvm',
    'lua',
    'make',
    'markdown',
    'ninja',
    'nix',
    'org',
    'python',
    'regex',
    'rst',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml'
  },
  highlight={enable=true},
  indent={enable=true},
  incremental_selection={
    enable=true,
    keymaps={
      init_selection='gnn',
      node_incremental='grn',
      scope_incremental='grc',
      node_decremental='grm'
    }
  },
  refactor={
    smart_rename={enable=true, keymaps={smart_rename='grr'}},
    highlight_definitions={enable=true}
    -- highlight_current_scope = { enable = true }
  },
  rainbow={enable=true, extended_mode=true},
  textobjects={
    select={
      enable=true,
      keymaps={
        ['af']='@function.outer',
        ['if']='@function.inner',
        ['aC']='@class.outer',
        ['iC']='@class.inner',
        ['ac']='@conditional.outer',
        ['ic']='@conditional.inner',
        ['ae']='@block.outer',
        ['ie']='@block.inner',
        ['al']='@loop.outer',
        ['il']='@loop.inner',
        ['is']='@statement.inner',
        ['as']='@statement.outer',
        ['ad']='@comment.outer',
        ['am']='@call.outer',
        ['im']='@call.inner'
      }
    }
  }
}

vim.api.nvim_command('set foldmethod=expr');
vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()');
