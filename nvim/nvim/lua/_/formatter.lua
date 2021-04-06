local has_config, formatter = pcall(require, 'formatter')

if not has_config then return end

local M = {}

local function prettier()
  return {
    exe='prettier',
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
      vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
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
          '--chop-down-table',
          '--double-quote-to-single-quote',
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

function M.setup() formatter.setup({logging=true, filetype=ftConfigs}) end

return M
