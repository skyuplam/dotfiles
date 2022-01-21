-- for debugging
-- :lua require('vim.lsp.log').set_level("debug")
-- :lua print(vim.inspect(vim.lsp.buf_get_clients()))
-- :lua print(vim.lsp.get_log_path())
-- :lua print(vim.inspect(vim.tbl_keys(vim.lsp.callbacks)))
local has_lsp, nvim_lsp = pcall(require, 'lspconfig')

if not has_lsp then return end

-- local has_lspsaga, lspsaga = pcall(require, 'lspsaga')
local has_extensions = pcall(require, 'lsp_extensions')
local has_lspstatus, lspstatus = pcall(require, 'lsp-status')
local has_lspsignature, lspsignature = pcall(require 'lsp_signature')
local has_rust_tools, rust_tools = pcall(require 'rust-tools')
local has_lightbulb = pcall(require 'nvim-lightbulb')
local has_schemastore, schemastore = pcall(require, 'schemastore')
local utils = require '_.utils'
local map_opts = {noremap=true, silent=true}
local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')

-- if has_lspsaga then lspsaga.init_lsp_saga() end

require'_.completion'.setup()

if has_lspstatus then
  lspstatus.config({
    indicator_errors=utils.get_icon('error'),
    indicator_warnings=utils.get_icon('warn'),
    indicator_info=utils.get_icon('info'),
    indicator_hint=utils.get_icon('hint'),
    indicator_ok=utils.get_icon('success')
  })

  lspstatus.register_progress()
end

if has_rust_tools then rust_tools.setup({}); end

utils.augroup('COMPLETION', function()
  if has_extensions then
    vim.api.nvim_command(
        'au CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost '
            .. '*.rs lua require\'lsp_extensions\'.inlay_hints({ '
            .. 'prefix = "", ' .. 'highlight = "Comment", '
            .. 'enabled = {"TypeHint", "ChainingHint", "ParameterHint"} })')
  end
end)

vim.fn.sign_define('LspDiagnosticsSignError', {
  text=utils.get_icon('error'),
  texthl='LspDiagnosticsDefaultError',
  linehl='',
  numhl=''
})

vim.fn.sign_define('LspDiagnosticsSignWarning', {
  text=utils.get_icon('warn'),
  texthl='LspDiagnosticsDefaultWarning',
  linehl='',
  numhl=''
})

vim.fn.sign_define('LspDiagnosticsSignInformation', {
  text=utils.get_icon('info'),
  texthl='LspDiagnosticsDefaultInformation',
  linehl='',
  numhl=''
})

vim.fn.sign_define('LspDiagnosticsSignHint', {
  text=utils.get_icon('hint'),
  texthl='LspDiagnosticsDefaultHint',
  linehl='',
  numhl=''
})

vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Key-mappings
local default_mappings = {
  ['<leader>a']={'<CMD>lua vim.lsp.buf.code_action()<CR>'},
  ['gr']={'<CMD>lua vim.lsp.buf.references()<CR>'},
  ['<leader>rn']={'<CMD>lua vim.lsp.buf.rename()<CR>'},
  ['<leader>dl']={'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'},
  ['<c-k>']={'<cmd>lua vim.lsp.buf.signature_help()<CR>'},
  ['[d']={'<CMD>lua vim.lsp.diagnostic.goto_next()<cr>'},
  [']d']={'<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>'},
  ['<C-]>']={'<Cmd>lua vim.lsp.buf.definition()<CR>'},
  ['gD']={'<CMD>lua vim.lsp.buf.declaration()<CR>'},
  ['gd']={'<CMD>lua vim.lsp.buf.definition()<CR>'},
  ['K']={'<CMD>lua vim.lsp.buf.hover()<CR>'},
  ['gy']={'<CMD>lua vim.lsp.buf.type_definition()<CR>'},
  ['gi']={'<CMD>lua vim.lsp.buf.implementation()<CR>'},
  ['<leader>q']={'<CMD>lua vim.lsp.diagnostics.set_loclist()<CR>'}
}

local mappings = vim.tbl_extend('force', default_mappings, {})

local on_attach = function(client)
  client.config.flags.allow_incremental_sync = true

  if has_lspstatus then lspstatus.on_attach(client) end
  if has_lspsignature then lspsignature.on_attach() end

  for lhs, rhs in pairs(mappings) do
    if lhs == 'K' then
      if vim.api.nvim_buf_get_option(0, 'filetype') ~= 'vim' then
        utils.bmap('n', lhs, rhs[1], map_opts)
      end
    else
      utils.bmap('n', lhs, rhs[1], map_opts)
      if #rhs == 2 then utils.bmap('v', lhs, rhs[2], map_opts) end
    end
  end

  -- Set some keybindings conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    utils.bmap('n', '<leader>f', '<CMD>lua vim.lsp.buf.formatting()<CR>',
               map_opts)
  elseif client.resolved_capabilities.document_range_formatting then
    utils.bmap('v', '<leader>f', '<CMD>lua vim.lsp.buf.range_formatting()<CR>',
               map_opts)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi! link LspReferenceRead SpecialKey
      hi! link LspReferenceText SpecialKey
      hi! link LspReferenceWrite SpecialKey
      ]], false)
  end

  utils.augroup('LSP', function()
    vim.api.nvim_command(
        'autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')
    if has_lightbulb then
      vim.api.nvim_command(
          'autocmd CursorHold,CursorHoldI * lua require\'nvim-lightbulb\'.update_lightbulb()')
    end
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_command(
          'autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()')
      vim.api.nvim_command(
          'autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()')
      vim.api.nvim_command(
          'autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
    end
  end)
end

local select_symbol = function(cursor_pos, symbol)
  if symbol.valueRange then
    local value_range = {
      ['start']={character=0, line=vim.fn.byte2line(symbol.valueRange[1])},
      ['end']={character=0, line=vim.fn.byte2line(symbol.valueRange[2])}
    }

    return require('lsp-status.util').in_range(cursor_pos, value_range)
  end
end

-- https://github.com/nvim-lua/diagnostic-nvim/issues/73
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Enable underline, use default values
      underline=true,
      -- Enable virtual text, override spacing to 4
      virtual_text={spacing=4, prefix='~'},
      -- Use a function to dynamically turn signs off
      -- and on, using buffer local variables
      signs=function(bufnr)
        local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
        -- No buffer local variable set, so just enable by default
        if not ok then return true end

        return result
      end,
      update_in_insert=true
    })

-- Enable (broadcasting) snippet capability for completion
local capabilities = has_lspstatus and lspstatus.capabilities
                         or vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- nvim-cmp
if has_cmp_lsp then cmp_lsp.update_capabilities(capabilities) end

require('nlua.lsp.nvim').setup(nvim_lsp,
                               {on_attach=on_attach, globals={'vim', 'use'}})

local eslint = {
  lintCommand='yarn eslint -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintStdin=true,
  lintIgnoreExitCode=true,
  lintFormats={'%f(%l,%c): %tarning %m', '%f(%l,%c): %rror %m'}
}

local prettier = {
  formatCommand='yarn prettier --stdin-filepath ${INPUT}',
  formatStdin=true
}

local jsons = {}
local yamls = {}

if has_schemastore then
  jsons = schemastore.json.schemas({
    select={
      '.eslintrc',
      'package.json',
      'tsconfig.json',
      'prettierrc.json',
      'babelrc.json',
      'lerna.json',
      '.stylelintrc'
    }
  })

  yamls = schemastore.json.schemas({
    select={
      'gitlab-ci',
      'docker-compose.yml',
      'GitHub Workflow',
      'GitHub Workflow Template Properties',
      'GitHub Action',
      'prettierrc.json',
      '.stylelintrc'
    }
  })
end

local servers = {
  cssls={},
  clangd={},
  jsonls={filetypes={'json', 'jsonc'}, settings={json={schemas=jsons}}},
  yamlls={settings={yaml={schemas=yamls}}},
  html={},
  efm={
    filetypes={
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx'
    },
    init_options={documentFormatting=true},
    root_dir=function(fname)
      return nvim_lsp.util.root_pattern('.yarn/')(fname)
                 or nvim_lsp.util.root_pattern('tsconfig.json')(fname)
    end,
    settings={
      rootMarkers={'.yarn/', '.git/'},
      languages={
        javascript={prettier, eslint},
        typescript={prettier, eslint},
        javascriptreact={prettier, eslint},
        typescriptreact={prettier, eslint}
      }
    }
  },
  vimls={},
  rust_analyzer={},
  tsserver={
    on_attach=function(client)
      on_attach(client)
      -- formatting is done via formatter.nvim
      client.resolved_capabilities.document_formatting = false
    end,
    root_dir=function(fname)
      return nvim_lsp.util.root_pattern('tsconfig.json')(fname)
                 or nvim_lsp.util
                     .root_pattern('package.json', 'jsconfig.json', '.git')(
                     fname) or vim.fn.getcwd()
    end
  }
}

for server, config in pairs(servers) do
  local server_disabled = (config.disabled ~= nil and config.disabled) or false

  if not server_disabled then
    nvim_lsp[server].setup(vim.tbl_deep_extend('force', {
      on_attach=on_attach,
      capabilities=capabilities,
      select_symbol=select_symbol
    }, config))
  end
end
