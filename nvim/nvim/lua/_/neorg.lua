local has_neorg, neorg = pcall(require, 'neorg')

if not has_neorg then return end

local M = {}

local note_dir = vim.g.zettel_not_dir or '~/notes'

function M.setup()
  neorg.setup({
    load={
      ['core.defaults']={},
      ['core.gtd.base']={config={workspace='home'}},
      ['core.norg.dirman']={
        config={workspaces={work=note_dir .. '/work', home=note_dir .. '/home'}}
      },
      ['core.presenter']={config={zen_mode='zen-mode'}},
      ['core.integrations.nvim-cmp']={},
      ['core.norg.qol.toc']={},
      ['core.norg.journal']={},
      ['core.norg.concealer']={},
      ['core.export']={}
    }
  })
end

return M
