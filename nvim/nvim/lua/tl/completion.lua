local has_cmp, cmp = pcall(require, 'cmp')
local has_lspkind, lspkind = pcall(require, 'lspkind')
local has_luasnip, luasnip = pcall(require, 'luasnip')

local M = {}

local format = {}

if has_lspkind then
  format = lspkind.cmp_format({
    mode = 'symbol', -- show only symbol annotations
    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    ellipsis_char = '...',
    symbol_map = { Codeium = '' },
  })
end

local cmp_window = {
  border = tl.style.current.border,
  winhighlight = table.concat({
    'Normal:NormalFloat',
    'FloatBorder:FloatBorder',
    'CursorLine:Visual',
    'Search:None',
  }, ','),
}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match('%s')
      == nil
end

local next = function(fallback)
  if cmp.visible() then
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    else
      cmp.select_next_item()
    end
    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    -- they way you will only jump inside the snippet region
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    end
  else
    fallback()
  end
end

local prev = function(fallback)
  if cmp.visible() then
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    else
      cmp.select_prev_item()
    end
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

local kind_score = {
  Variable = 1,
  Class = 2,
  Method = 3,
  Keyword = 4,
}

local kind_mapper = require('cmp.types').lsp.CompletionItemKind

M.setup = function()
  if not has_cmp then
    return
  end

  cmp.setup({
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    formatting = { format = format },
    sorting = {
      comparators = {
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        function(entry1, entry2)
          local kind1 = kind_score[kind_mapper[entry1:get_kind()]] or 100
          local kind2 = kind_score[kind_mapper[entry2:get_kind()]] or 100

          if kind1 < kind2 then
            return true
          end
        end,
      },
    },
    view = {
      docs = { auto_open = false },
    },
    snippet = {
      expand = function(args)
        if has_luasnip then
          luasnip.lsp_expand(args.body)
        end
      end,
    },
    -- preselect = cmp.PreselectMode.None,
    window = {
      completion = cmp.config.window.bordered(cmp_window),
      documentation = cmp.config.window.bordered(cmp_window),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-n>'] = cmp.mapping(next, { 'i', 's', 'c' }),
      ['<C-p>'] = cmp.mapping(prev, { 'i', 's', 'c' }),
      ['<C-g>'] = cmp.mapping(function()
        if cmp.visible_docs() then
          cmp.close_docs()
        else
          cmp.open_docs()
        end
      end),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
              })
            end
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
      ['<Tab>'] = cmp.mapping({
        i = next,
        s = next,
        c = function(_)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          else
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          end
        end,
      }),
      ['<S-Tab>'] = cmp.mapping({
        i = prev,
        s = prev,

        c = function(_)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_prev_item()
            end
          else
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          end
        end,
      }),
    }),
    sources = cmp.config.sources({
      { name = 'codeium' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_document_symbol' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' },
      { name = 'nvim_lua' },
      { name = 'tmux' },
      { name = 'path' },
      { name = 'spell' },
      { name = 'treesitter' },
      {
        name = 'rg',
        keyword_length = 4,
        max_item_count = 10,
        option = { additional_arguments = '--max-depth 8' },
      },
    }, { { name = 'buffer' } }),
  })
  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources(
      { { name = 'cmp_git' } },
      { { name = 'buffer' } }
    ),
  })

  cmp.setup.filetype('norg', {
    sources = cmp.config.sources(
      { { name = 'neorg' } },
      { { name = 'buffer' } }
    ),
  })
  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' },
      { name = 'cmdline_history', priority = 10, max_item_count = 5 },
    }, { { name = 'buffer' } }),
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'cmdline' },
      { name = 'path' },
      { name = 'cmdline_history', priority = 10, max_item_count = 5 },
    }),
    enabled = function()
      -- Set of commands where cmp will be disabled
      local disabled = {
        IncRename = true,
      }
      -- Get first word of cmdline
      local cmd = vim.fn.getcmdline():match('%S+')
      -- Return true if cmd isn't disabled
      -- else call/return cmp.close(), which returns false
      return not disabled[cmd] or cmp.close()
    end,
  })
end

return M
