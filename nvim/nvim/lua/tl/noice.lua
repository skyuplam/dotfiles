local has_noice, noice = pcall(require, 'noice')

local M = {}

function M.setup()
  if not has_noice then return end

  noice.setup({
    popupmenu={backend='cmp'},
    routes={
      {filter={event='msg_show', kind='search_count'}, opts={skip=true}},
      {filter={event='msg_show', kind='', find='written'}, opts={skip=true}}
    },
    -- add any options here
    lsp={
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override={
        ['vim.lsp.util.convert_input_to_markdown_lines']=true,
        ['vim.lsp.util.stylize_markdown']=true,
        ['cmp.entry.get_documentation']=true
      },
      signature={enabled=false}
    },
    -- you can enable a preset for easier configuration
    presets={
      bottom_search=true, -- use a classic bottom cmdline for search
      command_palette=true, -- position the cmdline and popupmenu together
      long_message_to_split=true, -- long messages will be sent to a split
      inc_rename=false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border=false -- add a border to hover docs and signature help
    }
  })
end

return M