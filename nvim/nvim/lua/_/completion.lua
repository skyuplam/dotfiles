local has_completion, completion = pcall(require, 'compe')
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
  if has_completion then
    completion.setup({
      enabled=true,
      autocomplete=true,
      debug=false,
      min_length=1,
      preselect='enable',
      throttle_time=80,
      source_timeout=200,
      resolve_timeout=800,
      incomplete_delay=400,
      max_abbr_width=100,
      max_kind_width=100,
      max_menu_width=100,
      documentation={
        border={'', '', '', ' ', '', '', '', ' '}, -- the border option is the same as `|help nvim_open_win|`
        winhighlight='NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
        max_width=120,
        min_width=60,
        max_height=math.floor(vim.o.lines * 0.3),
        min_height=1
      },

      source={
        path=true,
        buffer=true,
        calc=true,
        tags=true,
        spell=true,
        -- omni=true,
        emoji=true,
        nvim_lsp=true,
        nvim_lua=true,
        vsnip=true,
        tmux=true,
        nvim_treesitter=true
      }
    })

    utils.gmap('i', '<Tab>', 'v:lua._.tab_complete()', {expr=true})
    utils.gmap('s', '<Tab>', 'v:lua._.tab_complete()', {expr=true})
    utils.gmap('i', '<S-Tab>', 'v:lua._.s_tab_complete()', {expr=true})
    utils.gmap('s', '<S-Tab>', 'v:lua._.s_tab_complete()', {expr=true})
    utils.gmap('i', '<c-space>', 'compe#complete()',
               {expr=true, noremap=true, silent=true})
    utils.gmap('i', '<CR>', 'compe#confirm(\'<CR>\')',
               {expr=true, noremap=true, silent=true})

    utils.gmap('i', '<C-e>', 'compe#close(\'<C-e>\')',
               {expr=true, noremap=true, silent=true})

    utils.gmap('i', '<C-f>', 'compe#scroll({ \'delta\': +4 })',
               {expr=true, noremap=true, silent=true})

    utils.gmap('i', '<C-d>', 'compe#scroll({ \'delta\': -4 })',
               {expr=true, noremap=true, silent=true})
  end
end

return M
