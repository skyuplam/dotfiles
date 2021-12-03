local has_cmp, cmp = pcall(require, 'cmp')
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

M.setup = function()
  if has_cmp then

    cmp.setup({
      snippet={
        -- REQUIRED - you must specify a snippet engine
        expand=function(args)
          vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
        end
      },
      mapping={
        ['<C-b>']=cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>']=cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>']=cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>']=cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>']=cmp.mapping({i=cmp.mapping.abort(), c=cmp.mapping.close()}),
        ['<CR>']=cmp.mapping.confirm({select=true})
      },
      sources=cmp.config.sources({
        {name='nvim_lsp'},
        {name='vsnip'},
        {name='tmux'},
        {name='path'}
      }, {{name='buffer'}})
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {sources={{name='buffer'}}})

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      sources=cmp.config.sources({{name='path'}}, {{name='cmdline'}})
    })
  end
end

return M
