return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    -- { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<c-enter>'] = 'to_fuzzy_refine',
            ['<Esc>'] = actions.close,
            [''] = function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>', true, false, true), 'i', true)
            end,
            ['<C-BS>'] = function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>', true, false, true), 'i', true)
            end,
            -- ["<C-K>"] = actions.select_default,
            -- ["<C-h>"] = actions.cycle_history_next,
          },
          -- n  = {
          --   ["<C-K>"] = actions.select_default,
          -- },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {},
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sK', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader><leader>f', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sG', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Find existing [B]uffers' })

    -- Telescope live_grep in git root
    -- Function to find the git root directory based on the current buffer's path
    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
      -- If the buffer is not associated with a file, return nil
      if current_file == '' then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

      -- Find the Git root directory from the current file's path
      local git_root =
        vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
        print('Not a git repository. Searching on current working directory')
        return cwd
      end
      return git_root
    end

    -- Custom live_grep function to search in git root
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        builtin.live_grep({
          search_dirs = { git_root },
        })
      end
    end

    vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

    local function live_multigrep()
      local finder = require('telescope.finders').new_async_job {
        command_generator = function(prompt)
          if not prompt or prompt == '' then
            return nil
          end

          local pieces = vim.split(prompt, '  ')
          local args = { 'rg' }
          if pieces[1] then
            table.insert(args, '-e')
            table.insert(args, pieces[1])
          end

          if pieces[2] then
            table.insert(args, '-g')
            table.insert(args, pieces[2])
          end

          table.insert(args, '-g')
          table.insert(args, '!tests/**')

          return vim
            .iter({
              args,
              {
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
              },
            })
            :flatten()
            :totable()
        end,
        entry_maker = require('telescope.make_entry').gen_from_vimgrep({}),
        cwd = vim.uv.cwd(),
      }

      require('telescope.pickers')
        .new({}, {
          debounce = 100,
          prompt_title = '❅  Multi Grep ❅',
          finder = finder,
          previewer = require('telescope.config').values.grep_previewer({}),
          sorter = require('telescope.sorters').empty(),
        })
        :find()
    end

    local themes = require('telescope.themes')

    vim.keymap.set('n', '<leader>sg', live_multigrep, { desc = '[S]earch custom [G]rep' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader><leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sc', function()
      builtin.find_files { cwd = '~/nixos-config/' }
    end, { desc = '[S]earch [C]onfig' })

    vim.keymap.set('n', '<leader>k', function()
      builtin.find_files({ cwd = '~/cave/vault/', previewer = false })
    end, { desc = 'Search Vault' })

    vim.keymap.set('n', '<leader>K', function()
      builtin.find_files({ cwd = '~/cave/notes_proj/' })
    end, { desc = 'search Proj Notes' })

    vim.keymap.set('n', '<leader>sk', function()
      builtin.find_files({ cwd = '~/cave/kkk/' })
    end, { desc = '[S]search [K] Notes' })

    vim.keymap.set('n', '<Leader>f', function()
      builtin.find_files(themes.get_dropdown {
        previewer = false,
        file_ignore_patterns = { '^tests/' },
      })
    end, { desc = 'Search [F]iles' })

    vim.keymap.set('n', '<Leader>t', function()
      builtin.find_files(themes.get_dropdown {
        previewer = false,
        cwd = 'tests',
      })
    end, { desc = 'Search [T]ests' })

    vim.keymap.set('n', 'Ł', function()
      builtin.find_files({ cwd = '../.dev/' })
    end)

    vim.keymap.set('n', '<Leader>z', function()
      builtin.spell_suggest(themes.get_cursor({}))
    end, { desc = 'Spelling Suggestions' })
  end,
}
