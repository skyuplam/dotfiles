local has_cmp, cmp = pcall(require, 'cmp')
local has_lspkind, lspkind = pcall(require, 'lspkind')
local utils = require '_.utils'

local M = {}

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G._.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return utils.t '<C-n>'
  elseif vim.fn.call('vsnip#available', {1}) == 1 then
    return utils.t '<Plug>(vsnip-expand-or-jump)'
  elseif check_back_space() then
    return utils.t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G._.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return utils.t '<C-p>'
  elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
    return utils.t '<Plug>(vsnip-jump-prev)'
  else
    return utils.t '<S-Tab>'
  end
end

local format = {}

if has_lspkind then
  format = lspkind.cmp_format({
    mode='symbol', -- show only symbol annotations
    maxwidth=50 -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  })
end

M.setup = function()
  if has_cmp then

    cmp.setup({
      formatting={format=format},
      snippet={
        -- REQUIRED - you must specify a snippet engine
        expand=function(args)
          vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
        end
      },
      window={
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping=cmp.mapping.preset.insert({
        ['<C-b>']=cmp.mapping.scroll_docs(-4),
        ['<C-f>']=cmp.mapping.scroll_docs(4),
        ['<C-Space>']=cmp.mapping.complete(),
        ['<C-e>']=cmp.mapping.abort(),
        ['<CR>']=cmp.mapping.confirm({select=true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources=cmp.config.sources({
        {name='nvim_lsp'},
        {name='nvim_lsp_document_symbol'},
        {name='nvim_lsp_signature_help'},
        {name='nvim_lua'},
        {name='vsnip'},
        {name='tmux'},
        {name='path'}
      }, {{name='buffer'}})
    })
    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources=cmp.config.sources({{name='cmp_git'}}, {{name='buffer'}})
    })

    cmp.setup.filetype('norg', {
      sources=cmp.config.sources({{name='neorg'}}, {{name='buffer'}})
    })
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({'/', '?'}, {
      mapping=cmp.mapping.preset.cmdline(),
      sources={{name='buffer'}}
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping=cmp.mapping.preset.cmdline(),
      sources=cmp.config.sources({{name='path'}}, {{name='cmdline'}})
    })
  end
end

return M
