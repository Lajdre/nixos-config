return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPost' },
  lazy = true,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })

      -- Actions
      -- visual mode
      map('v', '<leader>ha', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'stage / add git hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'reset git hunk' })
      -- normal mode
      map('n', '<leader>ha', gitsigns.stage_hunk, { desc = 'git stage / [a]dd hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
      map('n', '<leader>hA', gitsigns.stage_buffer, { desc = 'git Stage / [A]dd buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
      map('n', '<leader>hhRR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
      map('n', '<leader>hi', gitsigns.preview_hunk_inline)
      map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
      end, { desc = 'git [b]lame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis '@'
      end, { desc = 'git [D]iff against last commit' })
      -- map('n', '<leader>hd', gitsigns.diffthis)
      -- map('n', '<leader>hD', function()
      --   gitsigns.diffthis('~')
      -- end)
      -- map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
      -- map('n', '<leader>hq', gitsigns.setqflist)

      -- Toggles
      map('n', '<leader>htb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
      map('n', '<leader>htD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      -- map('n', '<leader>tw', gitsigns.toggle_word_diff)

      -- Text object
      -- map({'o', 'x'}, 'ih', gitsigns.select_hunk)
    end,
  },
}
