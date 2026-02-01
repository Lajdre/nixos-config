return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  keys = {
    { '<Leader>hg', '<cmd>Neogit<CR>', desc = 'Open Neogit' },
    -- { '<Leader>hP', '<cmd>Neogit push<CR>', desc = 'Neogit push' },
    -- { '<Leader>hpp', '<cmd>Neogit pull<CR>', desc = 'Neogit pull' },
  },
  opts = {
    prompt_force_push = false,
    mappings = {
      popup = {
        ['w'] = false,
        ['W'] = 'WorktreePopup',
        ['X'] = false,
        ['<Space>X'] = 'ResetPopup',
      },
    },
  },
}
