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

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if has_lspstatus then lspstatus.on_attach(client) end
  if has_lspsignature then lspsignature.on_attach() end

  local attach_opts = {silent=true, buffer=bufnr}
  -- Key Mappings.
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, attach_opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, attach_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, attach_opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, attach_opts)
  vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, attach_opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                 attach_opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                 attach_opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, attach_opts)
  vim.keymap.set('n', '<leader>wo', function()
    require('telescope.builtin').lsp_document_symbols()
  end)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, attach_opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, attach_opts)
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
                 attach_opts)
  vim.keymap.set('n', '<leader>ld', require('telescope.builtin').diagnostics,
                 attach_opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, attach_opts)
end

vim.api.nvim_create_user_command('Format', vim.lsp.buf.format, {})

local handlers = {
  ['textDocument/hover']=function(...)
    local bufnr, _ = vim.lsp.handlers.hover(...)
    if bufnr then
      vim.keymap.set('n', 'K', '<Cmd>wincmd p<CR>', {silent=true, buffer=bufnr})
    end
  end
}

local select_symbol = function(cursor_pos, symbol)
  if symbol.valueRange then
    local value_range = {
      ['start']={character=0, line=vim.fn.byte2line(symbol.valueRange[1])},
      ['end']={character=0, line=vim.fn.byte2line(symbol.valueRange[2])}
    }

    return require('lsp-status.util').in_range(cursor_pos, value_range)
  end
end

-- Diagnostic settings
vim.diagnostic.config {virtual_text=true, signs=true, update_in_insert=true}

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
if has_cmp_lsp then capabilities = cmp_lsp.update_capabilities(capabilities) end

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

local codespell = {
  lintCommand='codespell',
  lintStdin=true,
  lintIgnoreExitCode=true,
  lintFormats={'%f:%l:%m'}
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

local jsonls = 'vscode-json-language-server';
if vim.fn.executable('vscode-json-languageserver') > 0 then
  jsonls = 'vscode-json-languageserver'
end
local htmlls = 'vscode-html-language-server';
if vim.fn.executable('vscode-html-languageserver') > 0 then
  htmlls = 'vscode-html-languageserver'
end

local servers = {
  cssls={},
  clangd={},
  jsonls={
    cmd={jsonls, '--stdio'},
    filetypes={'json', 'jsonc'},
    settings={json={schemas=jsons}}
  },
  yamlls={settings={yaml={schemas=yamls}}},
  html={cmd={htmlls, '--stdio'}},
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
        javascript={prettier, eslint, codespell},
        typescript={prettier, eslint, codespell},
        javascriptreact={prettier, eslint, codespell},
        typescriptreact={prettier, eslint, codespell}
      }
    }
  },
  vimls={},
  rust_analyzer={},
  tsserver={
    on_attach=function(client, bufnr)
      on_attach(client, bufnr)
      -- formatting is done via formatter.nvim
      -- client.server_capabilities.document_formatting = false
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
      select_symbol=select_symbol,
      handlers=handlers
    }, config))
  end
end
