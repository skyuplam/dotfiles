local has_formatter, formatter = pcall(require, 'formatter')

local M = {}

local function prettier()
  local pnp_prettier = './.yarn/sdks/prettier/index.js'
  local node_modules_prettier = './node_modules/.bin/prettier'
  local prettier_exe = 'prettier';
  if vim.fn.executable(pnp_prettier) == 1 then
    prettier_exe = 'yarn prettier';
  elseif vim.fn.executable(node_modules_prettier) == 1 then
    prettier_exe = node_modules_prettier;
  end
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

local function rome()
  local rome_exe = './node_modules/.bin/rome'
  if vim.fn.executable(rome_exe) == 1 then
    return {
      exe=rome_exe,
      args={
        'format',
        -- Get file
        '--stdin-file-path',
        vim.api.nvim_buf_get_name(0)
      },
      stdin=true
    }
  end
  return prettier()
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
  'markdown',
  'markdown.mdx',
  'json',
  'jsonc'
}

local javascriptFTs = {
  'javascript',
  'javascript.jsx',
  'javascriptreact',
  'typescript',
  'typescript.tsx',
  'typescriptreact'
}

for _, ft in ipairs(commonPrettierFTs) do ftConfigs[ft] = {prettier} end

for _, ft in ipairs(javascriptFTs) do ftConfigs[ft] = {rome} end

local function setup()
  local formatter_group = vim.api.nvim_create_augroup('Formatter', {clear=true})
  vim.api.nvim_create_autocmd('BufWritePost', {
    command='FormatWrite',
    group=formatter_group,
    pattern='*.js,*.jsx,*.ts,*.tsx,*.rs,*.md,*.json,*.lua'
  })

  return {logging=true, filetype=ftConfigs}
end

function M.setup()
  if not has_formatter then return end
  formatter.setup(setup())
end

return M
