-- for debugging
-- :lua require('vim.lsp.log').set_level("debug")
-- :lua print(vim.inspect(vim.lsp.buf_get_clients()))
-- :lua print(vim.lsp.get_log_path())
-- :lua print(vim.inspect(vim.tbl_keys(vim.lsp.callbacks)))
local has_lsp, nvim_lsp = pcall(require, 'lspconfig')

if not has_lsp then
  return
end

local has_lspsignature, lspsignature = pcall(require, 'lsp_signature')
local has_schemastore, schemastore = pcall(require, 'schemastore')
local has_rust_tools, rust_tools = pcall(require, 'rust-tools')
local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
local has_neodev, neodev = pcall(require, 'neodev')
local has_null_ls, null_ls = pcall(require, 'null-ls')
local command_resolver = require('null-ls.helpers.command_resolver')
local map = require('tl.common').map
local lsp = vim.lsp
local lsp_buf = lsp.buf
local lsp_util = lsp.util
local vim_api = vim.api

require('tl.completion').setup()

-- To instead override globally
local orig_util_open_floating_preview = lsp_util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function lsp_util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or tl.style.current.border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- https://github.com/nvimtools/none-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#avoid-breaking-formatexpr-ie-gq
local function is_null_ls_formatting_enabled(bufnr)
  local file_type = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local generators = require('null-ls.generators').get_available(
    file_type,
    require('null-ls.methods').internal.FORMATTING
  )
  return #generators > 0
end

local lsp_formatting = function(param)
  lsp_buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == 'null-ls'
    end,
    timeout_ms = 3000,
    bufnr = param.bufnr or 0,
  })
end
-- if you want to set up formatting on save, you can use this as a callback
local LspFormattingAUGroup = vim_api.nvim_create_augroup('LspFormatting', {})

if has_lspsignature then
  lspsignature.setup({ bind = true, handler_opts = { border = 'rounded' } })
end

local function supports_format(client)
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end
  return client.supports_method('textDocument/formatting')
    or client.supports_method('textDocument/rangeFormatting')
end

local on_attach = function(client, bufnr)
  local function attach_opts(desc)
    return { silent = true, buffer = bufnr, desc = desc }
  end
  vim_api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Format
  if supports_format(client) then
    vim_api.nvim_clear_autocmds({ group = LspFormattingAUGroup, buffer = bufnr })
    vim_api.nvim_create_autocmd('BufWritePre', {
      group = LspFormattingAUGroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting({ bufnr = bufnr })
      end,
    })
  end

  -- Inlay hint
  local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

  if inlay_hint then
    if client.server_capabilities.inlayHintProvider then
      inlay_hint.enable(bufnr, true)
    end
  end

  -- Key Mappings.
  if client.server_capabilities.documentFormattingProvider then
    if
      client.name == 'null-ls' and is_null_ls_formatting_enabled(bufnr)
      or client.name ~= 'null-ls'
    then
      vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'
      map(
        'n',
        '<leader>gq',
        '<cmd>lua vim.lsp.buf.format({ async = true })<CR>',
        attach_opts('LSP Format')
      )
    else
      vim.bo[bufnr].formatexpr = nil
    end
  end
  map('n', 'gd', lsp.buf.definition, attach_opts('Goto definition'))
  map('n', 'gD', lsp_buf.declaration, attach_opts('Goto declaration'))
  map(
    'n',
    '<leader>lo',
    vim.diagnostic.open_float,
    attach_opts('Show line diagnostic')
  )
  map('n', '[d', vim.diagnostic.goto_prev, attach_opts('Goto prev diagnostic'))
  map('n', ']d', vim.diagnostic.goto_next, attach_opts('Goto next diagnostic'))
  map(
    'n',
    '<leader>lq',
    vim.diagnostic.setloclist,
    attach_opts('Open diagnostics list')
  )
  if has_rust_tools and client.name == 'rust_analyzer' then
    map(
      'n',
      'K',
      rust_tools.hover_actions.hover_actions,
      attach_opts('Hover actions')
    )
  else
    map('n', 'K', lsp_buf.hover, attach_opts('Hover'))
  end
  -- map('n', 'gi', lsp_buf.implementation,
  --                attach_opts('Goto implementation'))
  map('n', '<C-s>', lsp_buf.signature_help, attach_opts('Signature help'))
  map(
    'n',
    '<leader>wa',
    lsp_buf.add_workspace_folder,
    attach_opts('Add workspace folder')
  )
  map(
    'n',
    '<leader>wr',
    lsp_buf.remove_workspace_folder,
    attach_opts('Remove workspace folder')
  )
  map('n', '<leader>wl', function()
    print(vim.inspect(lsp_buf.list_workspace_folders()))
  end, attach_opts('List workspace folder'))
  -- map('n', '<leader>D', lsp_buf.type_definition,
  --                attach_opts('Goto type definition'))
  -- map('n', '<leader>rn', lsp_buf.rename, attach_opts('Rename'))

  map('n', '<leader>rn', function()
    return ':IncRename ' .. vim.fn.expand('<cword>')
  end, { expr = true })
  map('n', '<leader>ca', lsp_buf.code_action, attach_opts('Code action'))
end

if has_null_ls then
  null_ls.setup({
    sources = {
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.ltrs,
      null_ls.builtins.completion.luasnip,
      null_ls.builtins.completion.spell,
      null_ls.builtins.completion.tags,
      null_ls.builtins.diagnostics.deadnix,
      null_ls.builtins.diagnostics.dotenv_linter,
      null_ls.builtins.diagnostics.gitlint,
      null_ls.builtins.diagnostics.ltrs.with({
        filetypes = { 'markdown' },
      }),
      null_ls.builtins.diagnostics.selene,
      null_ls.builtins.diagnostics.statix,
      null_ls.builtins.diagnostics.stylelint,
      null_ls.builtins.diagnostics.typos.with({
        filetypes = {
          'lua',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'json',
          'markdown',
          'toml',
          'rust',
        },
      }),
      null_ls.builtins.diagnostics.write_good,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.dprint,
      null_ls.builtins.formatting.nixpkgs_fmt,
      null_ls.builtins.formatting.alejandra,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.zigfmt,
      null_ls.builtins.formatting.prettier.with({
        dynamic_command = command_resolver.from_yarn_pnp(),
      }),
      null_ls.builtins.formatting.rustfmt.with({
        -- Read from Cargo.toml for edition
        extra_args = function(params)
          local Path = require('plenary.path')
          local cargo_toml = Path:new(params.root .. '/' .. 'Cargo.toml')

          if cargo_toml:exists() and cargo_toml:is_file() then
            for _, line in ipairs(cargo_toml:readlines()) do
              local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
              if edition then
                return { '--edition=' .. edition }
              end
            end
          end
          -- default edition when we don't find `Cargo.toml` or the `edition` in it.
          return { '--edition=2021' }
        end,
      }),
      null_ls.builtins.formatting.yq,
    },
  })
end

vim_api.nvim_create_user_command('Format', lsp_formatting, {})

local select_symbol = function(cursor_pos, symbol)
  if symbol.valueRange then
    local value_range = {
      ['start'] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[1]),
      },
      ['end'] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[2]),
      },
    }

    return require('lsp-status.util').in_range(cursor_pos, value_range)
  end
end

-- Diagnostic settings
vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    only_current_line = true,
  },
})

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- nvim-cmp
if has_cmp_lsp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
if has_neodev then
  neodev.setup({
    library = { enabled = true, runtime = true, types = true, plugins = true },
    setup_jsonls = true,
    lspconfig = true,
    pathStrict = true,
  })
end

local rust_tool_setup = function()
  if not has_rust_tools then
    return
  end
  local extension_path = vim.env.HOME
    .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
  if vim.fn.isdirectory('/usr/lib/codelldb/') == 1 then
    extension_path = '/usr/lib/codelldb/'
  end

  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

  rust_tools.setup({
    tools = {
      runnables = { use_telescope = true },
      debuggables = { use_telescope = true },
    },
    server = {
      cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = true,
            -- https://github.com/rust-analyzer/rust-analyzer/issues/6835
            disabled = { 'unresolved-macro-call' },
            enableExperimental = true,
          },
          completion = {
            autoself = { enable = true },
            autoimport = { enable = true },
            postfix = { enable = true },
          },
          imports = {
            group = { enable = true },
            merge = { glob = false },
            prefix = 'self',
            granularity = {
              enforce = true,
              group = 'crate',
            },
          },
          cargo = {
            loadOutDirsFromCheck = true,
            autoreload = true,
            runBuildScripts = true,
            features = 'all',
            -- https://github.com/rust-lang/rust-analyzer/issues/13400
            target = 'wasm32-unknown-unknown',
          },
          procMacro = {
            enable = true,
            attributes = { enable = true },
          },
          lens = {
            enable = true,
            run = { enable = true },
            debug = { enable = true },
            implementations = { enable = true },
            references = {
              adt = { enable = true },
              enumVariant = { enable = true },
              method = { enable = true },
              trait = { enable = true },
            },
          },
          hover = {
            actions = {
              enable = true,
              run = { enable = true },
              debug = { enable = true },
              gotoTypeDef = { enable = true },
              implementations = { enable = true },
              references = { enable = true },
            },
            links = { enable = true },
            documentation = { enable = true },
          },
          inlayHints = {
            enable = true,
            bindingModeHints = { enable = true },
            chainingHints = { enable = true },
            closingBraceHints = {
              enable = true,
              minLines = 0,
            },
            closureReturnTypeHints = { enable = 'always' },
            lifetimeElisionHints = { enable = 'skip_trivial' },
            typeHints = { enable = true },
          },
          checkOnSave = {
            enable = true,
            -- https://github.com/rust-analyzer/rust-analyzer/issues/9768
            command = 'clippy',
            features = 'all',
            allTargets = true,
          },
        },
      },
      standalone = false,

      on_attach = on_attach,
    },
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
        codelldb_path,
        liblldb_path
      ),
    },
  })
end

rust_tool_setup()

local jsons = {}
local yamls = {}

if has_schemastore then
  jsons = schemastore.json.schemas({
    select = {
      '.eslintrc',
      'package.json',
      'tsconfig.json',
      'prettierrc.json',
      'babelrc.json',
      'lerna.json',
      'JSON Resume',
      '.stylelintrc',
    },
  })

  yamls = schemastore.json.schemas({
    select = {
      'gitlab-ci',
      'docker-compose.yml',
      'GitHub Workflow',
      'GitHub Workflow Template Properties',
      'GitHub Action',
      'prettierrc.json',
      '.stylelintrc',
    },
    extra = {
      {
        description = 'kubernetes',
        fileMatch = { 'config', '*.yaml', '*.k8s.yaml' },
        name = 'all.json',
        url = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.3-standalone-strict/all.json',
      },
    },
  })
end

local jsonls = 'vscode-json-language-server'
if vim.fn.executable('vscode-json-languageserver') > 0 then
  jsonls = 'vscode-json-languageserver'
end
local htmlls = 'vscode-html-language-server'
if vim.fn.executable('vscode-html-languageserver') > 0 then
  htmlls = 'vscode-html-languageserver'
end

local servers = {
  cssls = {},
  clangd = {},
  jsonls = {
    cmd = { jsonls, '--stdio' },
    filetypes = { 'json', 'jsonc' },
    settings = { json = { schemas = jsons, validate = { enable = true } } },
  },
  yamlls = {
    settings = { yaml = { schemas = yamls, validate = { enable = true } } },
  },
  html = { cmd = { htmlls, '--stdio' } },
  vimls = {},
  marksman = {},
  zls = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        workspace = {
          checkThirdParty = false,
        },
        completion = { callSnippet = 'Replace' },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },
  },
  eslint = {
    settings = {
      -- `packageManager` and `nodePath` are set to ensure that the eslint LS
      -- will work with pnp.
      -- https://github.com/neovim/nvim-lspconfig/issues/1872
      nodePath = vim.fn.getcwd() .. '/.yarn/sdks',
      packageManager = 'yarn',
      codeActionOnSave = { enable = true, mode = 'all' },
    },
  },
  glslls = {},
  wgsl_analyzer = {},
  tsserver = {
    on_attach = on_attach,
    init_options = {
      hostInfo = 'neovim',
      preferences = {
        allowIncompleteCompletions = true,
        includeCompletionsForModuleExports = false,
      },
    },
    flags = { debounce_text_changes = 500, allow_incremental_sync = true },
    root_dir = function(fname)
      return nvim_lsp.util.root_pattern('tsconfig.json')(fname)
        or nvim_lsp.util.root_pattern('package.json', 'jsconfig.json', '.git')(
          fname
        )
        or vim.fn.getcwd()
    end,
    settings = {
      typescript = {
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = {
          enabled = true,
          showOnAllFunctions = true,
        },
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        referencesCodeLens = { enabled = true },
        implementationsCodeLens = { enabled = true },
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
}

for server, config in pairs(servers) do
  local server_disabled = (config.disabled ~= nil and config.disabled) or false

  if not server_disabled then
    nvim_lsp[server].setup(vim.tbl_deep_extend('force', {
      on_attach = on_attach,
      capabilities = capabilities,
      select_symbol = select_symbol,
      -- handlers = handlers
    }, config))
  end
end
