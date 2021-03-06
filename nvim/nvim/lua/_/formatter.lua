local has_config, formatter = pcall(require, 'formatter')

if not has_config then return end

local utils = require '_.utils'

local M = {}

local function prettier()
  local local_prettier = './node_modules/.bin/prettier'
  local prettier_exe = 'prettier';
  if vim.fn.executable(local_prettier) then prettier_exe = local_prettier end
  return {
    exe=prettier_exe,
    args={
      -- Config prettier
      '--config-precedence',
      'prefer-file',
      '--no-bracket-spacing',
      '--single-quote',
      '--trailing-comma',
      'all',
      -- Get file
      '--stdin-filepath',
      vim.api.nvim_buf_get_name(0)
    },
    stdin=true
  }
end

local function shfmt() return {exe='shfmt', args={'-'}, stdin=true} end

local ftConfigs = {
  lua={
    function()
      return {
        exe='lua-format',
        args={
          vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
          '--tab-width=2',
          '--indent-width=2',
          '--align-table-field',
          '--chop-down-table',
          '--chop-down-parameter',
          '--double-quote-to-single-quote',
          '--no-break-after-operator',
          '--no-spaces-inside-table-braces',
          '--no-spaces-around-equals-in-field',
          '--no-spaces-inside-functioncall-parens',
          '--no-spaces-inside-functiondef-parens'
        },
        stdin=true
      }
    end
  },
  rust={
    function() return {exe='rustfmt', args={'--emit=stdout'}, stdin=true} end
  },
  nix={function() return {exe='nixpkgs-fmt', stdin=true} end},
  sh={shfmt},
  bash={shfmt}
}

local commonPrettierFTs = {
  'css',
  'scss',
  'less',
  'html',
  'yaml',
  'java',
  'javascript',
  'javascript.jsx',
  'javascriptreact',
  'typescript',
  'typescript.tsx',
  'typescriptreact',
  'markdown',
  'markdown.mdx',
  'json'
}

for _, ft in ipairs(commonPrettierFTs) do ftConfigs[ft] = {prettier} end

local function setup()
  utils.augroup('FormatAU', function()
    vim.api.nvim_command(
        'autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.rs,*.md,*.json,*.lua FormatWrite')
  end)
  return {logging=true, filetype=ftConfigs}
end

function M.setup() formatter.setup(setup()) end

return M
