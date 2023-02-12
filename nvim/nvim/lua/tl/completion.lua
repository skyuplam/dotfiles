local has_cmp, cmp = pcall(require, 'cmp')
local has_lspkind, lspkind = pcall(require, 'lspkind')
local has_luasnip, luasnip = pcall(require, 'luasnip')

local M = {}

-- local check_back_space = function()
--   local col = vim.fn.col('.') - 1
--   if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--     return true
--   else
--     return false
--   end
-- end

local format = {}

if has_lspkind then
  format = lspkind.cmp_format({
    mode='symbol', -- show only symbol annotations
    maxwidth=50 -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  })
end

local function next(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local function prev(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

local cmp_window = {
  border=tl.style.current.border,
  winhighlight=table.concat({
    'Normal:NormalFloat',
    'FloatBorder:FloatBorder',
    'CursorLine:Visual',
    'Search:None'
  }, ',')
}

M.setup = function()
  if not has_cmp then return end

  cmp.setup({
    formatting={format=format},
    snippet={expand=function(args) luasnip.lsp_expand(args.body) end},
    preselect=cmp.PreselectMode.None,
    window={
      completion=cmp.config.window.bordered(cmp_window),
      documentation=cmp.config.window.bordered(cmp_window)
    },
    mapping=cmp.mapping.preset.insert({
      ['<C-n>']=cmp.mapping(next, {'i', 's', 'c'}),
      ['<C-p>']=cmp.mapping(prev, {'i', 's', 'c'}),
      ['<C-b>']=cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
      ['<C-f>']=cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
      ['<C-Space>']=cmp.mapping.complete(),
      ['<C-e>']=cmp.mapping.abort(),
      ['<CR>']=cmp.mapping.confirm({select=true})
    }),
    sources=cmp.config.sources({
      {name='nvim_lsp'},
      {name='nvim_lsp_document_symbol'},
      {name='nvim_lsp_signature_help'},
      {name='luasnip'},
      {name='nvim_lua'},
      {name='tmux'},
      {name='path'},
      {name='spell'},
      {
        name='rg',
        keyword_length=4,
        max_item_count=10,
        option={additional_arguments='--max-depth 8'}
      }
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
    sources=cmp.config.sources({{name='nvim_lsp_document_symbol'}},
                               {{name='buffer'}})
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping=cmp.mapping.preset.cmdline(),
    sources=cmp.config.sources({
      {name='cmdline'},
      {name='path'},
      {name='cmdline_history', priority=10, max_item_count=5}
    })
  })
end

return M
