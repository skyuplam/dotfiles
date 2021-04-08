-- for debugging
-- :lua require('vim.lsp.log').set_level("debug")
-- :lua print(vim.inspect(vim.lsp.buf_get_clients()))
-- :lua print(vim.lsp.get_log_path())
-- :lua print(vim.inspect(vim.tbl_keys(vim.lsp.callbacks)))
local has_lsp, nvim_lsp = pcall(require, 'lspconfig')

if not has_lsp then return end

local has_lspsaga, lspsaga = pcall(require, 'lspsaga')
local has_extensions = pcall(require, 'lsp_extensions')
local has_lspstatus, lspstatus = pcall(require, 'lsp-status')
local utils = require '_.utils'
local map_opts = {noremap=true, silent=true}

lspsaga.init_lsp_saga()

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

utils.augroup('COMPLETION', function()
  if has_extensions then
    vim.api.nvim_command(
        'au CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs lua require\'lsp_extensions\'.inlay_hints()')
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

local default_mappings = {
  ['<leader>a']={'<Cmd>lua vim.lsp.buf.code_action()<CR>'},
  ['gr']={'<cmd>lua vim.lsp.buf.references()<CR>'},
  ['<leader>rn']={'<cmd>lua vim.lsp.buf.rename()<CR>'},
  ['K']={'<Cmd>lua vim.lsp.buf.hover()<CR>'},
  ['<leader>ld']={'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'},
  ['[d']={'<cmd>lua vim.lsp.diagnostic.goto_next()<cr>'},
  [']d']={'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'},
  ['<C-]>']={'<Cmd>lua vim.lsp.buf.definition()<CR>'},
  ['gd']={'<Cmd>lua vim.lsp.buf.declaration()<CR>'},
  ['gi']={'<cmd>lua vim.lsp.buf.implementation()<CR>'}
}

local lspsaga_mappings = {
  ['<C-]>']={
    '<Cmd>lua require\'lspsaga.provider\'.preview_definition()<CR>'
  },
  ['<leader>a']={
    '<Cmd>lua require\'lspsaga.codeaction\'.code_action()<CR>',
    '<Cmd>\'<,\'>lua require\'lspsaga.codeaction\'.range_code_action()<CR>'
  },
  ['gr']={'<cmd>lua require\'lspsaga.provider\'.lsp_finder()<CR>'},
  ['<leader>s']={
    '<cmd>lua require\'lspsaga.signaturehelp\'.signature_help()<CR>'
  },
  ['<leader>rn']={'<cmd>lua require\'lspsaga.rename\'.rename()<CR>'},
  ['<leader>ld']={
    '<cmd>lua require\'lspsaga.diagnostic\'.show_line_diagnostics()<CR>'
  },
  ['[d']={
    '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_prev()<CR>'
  },
  [']d']={
    '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_next()<CR>'
  },
  ['K']={'<cmd>lua require(\'lspsaga.hover\').render_hover_doc()<cr>'},
  ['<C-f>']={
    '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<cr>'
  },
  ['<C-j>']={
    '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>'
  }
}

local mappings = vim.tbl_extend('force', default_mappings,
                                has_lspsaga and lspsaga_mappings or {})

local on_attach = function(client)
  client.config.flags.allow_incremental_sync = true

  if has_lspstatus then lspstatus.on_attach(client) end

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

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    utils.bmap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", map_opts)
  elseif client.resolved_capabilities.document_range_formatting then
    utils.bmap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", map_opts)
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
      virtual_text=false,
      -- virtual_text = {
      --   spacing = 4,
      --   prefix = "~"
      -- },
      underline=false,
      signs=true,
      update_in_insert=false
    })

-- Enable (broadcasting) snippet capability for completion
local capabilities = lspstatus.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('nlua.lsp.nvim').setup(nvim_lsp,
                               {on_attach=on_attach, globals={'vim', 'use'}})

local eslint = {
  lintCommand='eslint_d -f unix --stdin --stdin-filename ${INPUT}',
  lintStdin=true,
  lintFormats={'%f:%l:%c: %m'},
  lintIgnoreExitCode=true,
  formatCommand='eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin=true
}

local servers = {
  cssls={},
  jsonls={},
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
    init_options={codeAction=true, documentFormatting=true},
    root_dir=nvim_lsp.util.root_pattern('.git', vim.fn.getcwd()),
    settings={
      rootMarkers={'package.json', '.git/'},
      languages={
        javascript={eslint},
        typescript={eslint},
        javascriptreact={eslint},
        typescriptreact={eslint}
      }
    }
  },
  vimls={},
  rust_analyzer={},
  tsserver={
    on_attach=function(client)
      on_attach(client)
      -- formating is done via formatter.nvim
      client.resolved_capabilities.document_formatting = false
    end,
    root_dir=function(fname)
      return nvim_lsp.util.root_pattern('tsconfig.json')(fname)
                 or nvim_lsp.util.root_pattern('package.json', 'jsconfig.json',
                                               '.git')(fname) or vim.fn.getcwd()
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
