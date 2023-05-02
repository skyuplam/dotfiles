local has_neorg, neorg = pcall(require, 'neorg')

local M = {}

local note_dir = '~/Dropbox/notes/'

function M.setup()

  if not has_neorg then return end

  neorg.setup({
    load={
      ['core.defaults']={},
      ['core.concealer']={},
      ['core.dirman']={
        config={workspaces={work=note_dir .. 'work', home=note_dir .. 'home'}}
      },
      ['core.presenter']={config={zen_mode='truezen'}},
      ['core.integrations.nvim-cmp']={},
      ['core.integrations.telescope']={},
      ['core.completion']={config={engine='nvim-cmp'}},
      ['core.export']={}
    }
  })
end

return M
