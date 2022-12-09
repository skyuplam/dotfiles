local has_bufferline, bufferline = pcall(require, 'bufferline')

local utils = require('_.utils')

local M = {}

function M.setup()
  if not has_bufferline then return end

  bufferline.setup({
    options={
      sort_by='insert_after_current',
      diagnostics='nvim_lsp',
      diagnostics_indicator=function(count, level)
        return (utils.get_icon(level) or '?') .. ' ' .. count
      end,
      diagnostics_update_in_insert=false,
      hover={enabled=true, reveal={'close'}},
      offsets={
        {
          filetype='NvimTree',
          text='File Explorer',
          text_align='center',
          separator=true
        },
        {
          text=' PACKER',
          filetype='packer',
          highlight='PanelHeading',
          separator=true
        },
        {
          text=' DIFF VIEW',
          filetype='DiffviewFiles',
          highlight='PanelHeading',
          separator=true
        }
      }
    }
  })

  vim.keymap.set('n', ']b', '<Cmd>BufferLineCycleNext<CR>')
  vim.keymap.set('n', '[b', '<Cmd>BufferLineCyclePrev<CR>')
end

return M
