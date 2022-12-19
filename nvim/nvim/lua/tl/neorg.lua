local has_neorg, neorg = pcall(require, 'neorg')

local M = {}

local note_dir = '~/Dropbox/notes/'

function M.setup()

  if not has_neorg then return end

  neorg.setup({
    load={
      ['core.defaults']={},
      ['core.gtd.base']={config={workspace='home'}},
      ['core.norg.dirman']={
        config={workspaces={work=note_dir .. 'work', home=note_dir .. 'home'}}
      },
      ['core.presenter']={config={zen_mode='truezen'}},
      ['core.integrations.nvim-cmp']={},
      ['core.integrations.telescope']={},
      ['core.norg.qol.toc']={},
      ['core.norg.journal']={},
      ['core.norg.concealer']={},
      ['core.norg.completion']={config={engine='nvim-cmp'}},
      ['core.export']={}
    }
  })
end

return M
