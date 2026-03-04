local Job = require('plenary.job')

local function m(a, b, v)
  vim.keymap.set(a, b, v, { noremap = true })
end

m({ 'n', 'v' }, '<Space>', '<Nop>')

m('v', 'y', 'myy`y') -- keeps the position of the cursor after v yank

m({ 'n', 'v' }, ';', ':')
m('n', ':', ';')

m({ 'n', 'x' }, 'x', '"_x') -- Prevent x from overwriting clippboard
m('n', '<A-d>', '"_dd')
m('n', '<A-D>', '"_d')
m('v', '<A-d>', '"_d')

m('v', '>', '>gv')
m('v', '<', '<gv')

m('n', '<A-q>', "m'gqip`'")

m('n', '<C-j>', '<c-w>j')
m('n', '<C-k>', '<c-w>k')
m('n', '<C-l>', '<c-w>l')
m('n', '<C-h>', '<c-w>h')

m('n', 'go', 'o<Esc>k')
m('n', 'gO', 'O<Esc>j')

m('n', '<Down>', '<c-w>-')
m('n', '<Up>', '<c-w>+')
m('n', '<A-Left>', '<c-w>>')
m('n', '<A-Right>', '<c-w><')
m('n', '<Left>', '<cmd>cprev<CR>')
m('n', '<Right>', '<cmd>cnext<CR>')

m('i', '<A-7>', '<Esc>gT') -- Zellij for some reason eats Control PageUp (booo)
m('i', '<A-8>', '<Esc>gt')
m('n', '<A-7>', 'gT')
m('n', '<A-8>', 'gt')

m('n', 'q', function()
  vim.cmd('normal gcc')
end)
m('v', 'q', function()
  vim.cmd('normal gc')
end)

m('x', 'J', ":m '>+1<CR>gv=gv")
m('x', 'K', ":m '<-2<CR>gv=gv")

m('n', '<A-y>', '"zyy"zp') -- paste line under
m('n', '<Leader><A-y>', function() -- comment the line and paste it under
  vim.cmd('normal! "zyy')
  vim.cmd('normal gcc')
  vim.cmd('normal! "zp')
end)
-- comment block and paste it under. Works with the cursor on the bottom of the block ("o" to switch)
m('x', '<Leader><A-y>', function()
  vim.cmd('normal! "zygv')
  vim.cmd('normal gc')
  vim.cmd('normal! gv\x1bo\x1b"zp')
end)

m('n', '<Esc>', '<cmd>nohl<Cr>')

-- C-v, but it will immediately format the line according to the textwidth, if set
m('i', '<M-C-V>', '<C-R>+')
-- TODO? make it so that the text is not formattet when not in .md etc. I think removing textwidth does not change anything.
m('n', '<M-C-V>', function()
  vim.cmd('normal "+p')
  vim.cmd('normal gqq')
end)

m('n', 'dd', 'D')
m('n', 'C', 'ciw')
m('n', 'cc', 'C')
m('n', 'f', 'V')
m('n', 'F', 'v')
m('n', 'v', 'dd')
m('n', 'z', 'v')
m({ 'n', 'v' }, 'e', '<C-d>')
m({ 'n', 'v' }, 'w', '<C-u>')
m('n', 'H', 'n')
m('n', 'L', 'N')
m('n', 'm', 'e')
m('n', 'M', 'E')
m({ 'n', 'v' }, 'n', 'w')
m({ 'n', 'v' }, 'N', 'W')
m({ 'n', 'v' }, 'D', 'w')
m({ 'n', 'v' }, 'F', 'W')

m('n', 'Y', 'yy')
m('n', 'yy', 'y$')

m('n', 'J', 'mzJ`z')

m('n', '<', '<<') -- delay like there is multiple keymaps that start with "<" and does not even show up in Telescope keymaps
m('n', '>', '>>')

m('n', '<A-p>', "<cmd>pu<CR>V'[=") -- paste under / over and automatically allign using "=". Also see :h ]p and [P
m('n', 'p', '<cmd>pu<CR>')
m('n', '<A-P>', "<cmd>pu!<CR>V']=")
m('n', 'P', '<cmd>pu!<CR>')
-- m('x', 'p', '"_dP') -- paste without trashing the clippboard. Not needed when using Ctrl-c

-- m('n', 't', 'yiw') -- make it keep the position
-- m('n', 'T', 'viw"_dP')
-- m('n', '<A-t>', 'yiW')
-- m('n', '<A-T>', 'viW"_dP')
m('n', 'r', 'yiw') -- make it keep the position
m('n', 'R', 'viw"_dP')
m('n', '<A-r>', 'yiW')
m('n', '<A-R>', 'viW"_dP')
m('n', 't', 'r')
m('n', 'T', 'R')

m('n', '<Leader><Leader>Q', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('q', true, false, true), 'n', true)
end)

m('n', 'gt', '<cmd>vsp | lua vim.lsp.buf.definition()<CR>')

m({ 'i', 'c' }, '', '<C-w>') -- map Control Backspace to Control W
m({ 'i', 'c' }, '<C-BS>', '<C-w>')
m('c', '<Up>', '<C-p>')
m('c', '<Down>', '<C-n>')
m('c', '<C-p>', '<Up>')
m('c', '<C-n>', '<Down>')

m('i', '<A-=>', ' == ')

m('n', '-', '<CMD>Oil<CR>')

m({ 'n', 'i' }, '<C-e>', function()
  vim.cmd('w')
end)

m('n', '<Leader><Leader>p', '<CMD>RenderMarkdown toggle<CR>')

m('n', '<leader>hc', ':!git commit -m""<Left>')
m('n', '<Leader>hP', '<cmd>!git push<CR>')

-- yank visual selection to clipboard wrapped in code fences
m('v', 'Y', function()
  vim.cmd('normal! mY"zy`Y')
  local selected_text = vim.fn.getreg('z')

  local filetype = vim.bo.filetype
  if filetype == '' then
    filetype = 'text'
  end

  local formatted_text = '```' .. filetype .. '\n' .. selected_text .. '```'
  vim.fn.setreg('+', formatted_text)
end)

m('n', 'gy', '<CMD>silent %y+<CR>')

m('n', 'gY', function()
  local ft = vim.bo.filetype == '' and 'text' or vim.bo.filetype
  vim.fn.setreg('+', '```' .. ft .. '\n' .. table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n') .. '\n```')
end)

m('n', 'g<Leader>y', function()
  local ft = vim.bo.filetype == '' and 'text' or vim.bo.filetype
  local relative_name = vim.fn.expand('%:~:.')
  local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
  vim.fn.setreg('+', relative_name .. '\n```' .. ft .. '\n' .. content .. '\n```')
end)

m('i', "<A-'>", function() -- I wasted 3 hours on this
  -- vim.api.nvim_feedkeys('\x1blyla, \x12"\x12"' .. vim.api.nvim_replace_termcodes("<Left>", true, false, true), "m", true) -- \x16 for c-c; 12 for c-r
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local char_under_cursor = vim.api.nvim_get_current_line():sub(col + 1, col + 1)

  if char_under_cursor == ')' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ', (', 'm', true)
  elseif char_under_cursor == ']' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ', [', 'm', true)
  elseif char_under_cursor == '}' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ', {', 'm', true)
  elseif char_under_cursor == '"' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ', "', 'm', true)
  elseif char_under_cursor == "'" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ", '", 'm', true)
  end
end)

m('n', '<Leader><Leader><Leader>c', function() -- clear all ^M
  vim.api.nvim_feedkeys(
    ';%s/'
      .. vim.api.nvim_replace_termcodes('<C-q>', true, false, true)
      .. vim.api.nvim_replace_termcodes('<C-m>', true, false, true)
      .. '//g\r',
    'm',
    true
  )
end)

local virtual_text_enabled = false
m('n', '<LocalLeader>e', function()
  virtual_text_enabled = not virtual_text_enabled
  vim.diagnostic.config({ virtual_text = virtual_text_enabled })
end)

m('n', 'gT', function() -- open current file in a new tab
  vim.cmd('normal! ma')
  vim.cmd('tabedit %')
  vim.cmd('normal! `a')
end)

m('n', '<Leader><Leader>o', function() -- toggle autoformat
  vim.g.enable_autoformat = not vim.g.enable_autoformat
  vim.notify('Autoformat ' .. (vim.g.enable_autoformat and 'Enabled' or 'Disabled'), vim.log.levels.INFO)
end)

m('n', '<Leader><Leader>O', function() -- format file based on the extension
  local file_type = vim.bo.filetype
  vim.cmd('w')
  if file_type == 'python' then
    vim.cmd('! black ' .. vim.api.nvim_buf_get_name(0))
  elseif file_type == 'rust' then
    vim.cmd('! rustfmt ' .. vim.api.nvim_buf_get_name(0))
    -- vim.cmd("RustFmt") Does not work and I dont want to install rust-lang/rust.vim to fix it
  elseif file_type == 'cpp' then
    vim.lsp.buf.format()
  elseif file_type == 'lua' then
    -- ad hoc
    -- vim.cmd("! stylua " .. vim.api.nvim_buf_get_name(0))
    -- search-parent-directories | vim.fn.findfile(".stylua.toml", vim.fn.getcwd())
    -- local stylua_toml = vim.fn.findfile(".stylua.toml", vim.fn.getcwd() .. ";")
    local args = { '--config-path', '.stylua.toml', '-' }
    local errors = {}
    local job = Job:new({
      command = 'stylua',
      args = args,
      writer = vim.api.nvim_buf_get_lines(0, 0, -1, false),
      on_stderr = function(_, data)
        table.insert(errors, data)
      end,
    })
    local output = job:sync()
    if job.code == 0 then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
    else
      vim.schedule(function()
        error(string.format('[stylua] %s', errors[1] or 'Failed to format due to errors'))
      end)
    end
  end
end)

m({ 'n', 't' }, 'X', '<Esc><cmd>wa<CR><cmd>qa<CR>')

m('n', '<Leader>hc', ':!git commit -m""<Left>')
m('n', '<Leader>hP', '<cmd>!git push<CR>')

vim.keymap.set('n', '<CR>', function()
  if vim.bo.filetype ~= 'markdown' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', true)
    return
  end

  local line = vim.api.nvim_get_current_line()
  local s, bracket_pos = line:find('^%s*%- %[')
  if not s then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', true)
    return
  end

  local row = vim.api.nvim_win_get_cursor(0)[1]
  local marker_pos = bracket_pos + 1
  local marker = line:sub(marker_pos, marker_pos)
  local new_marker

  local count = vim.v.count -- retrieves the count provided before the keypress
  if count and count > 0 then
    if count == 1 then
      new_marker = '-'
    elseif count == 2 then
      new_marker = '>'
    elseif count == 3 then
      new_marker = '?'
    elseif count == 4 then
      new_marker = '='
    elseif count == 5 then
      new_marker = '*'
    elseif count == 6 then
      new_marker = '!'
    elseif count == 7 then
      new_marker = '~'
    elseif count == 8 then
      new_marker = '_'
    end
  else
    if marker == ' ' or marker == '!' or marker == '-' or marker == '~' then
      new_marker = 'x'
    else
      new_marker = ' '
    end
  end

  if new_marker then
    vim.api.nvim_buf_set_text(0, row - 1, marker_pos - 1, row - 1, marker_pos, { new_marker })
  end
end, { noremap = true })

m('n', '<Leader>l', function()
  -- vim.opt_local.spell = not vim.opt_local.spell:get()
  vim.wo.spell = not vim.wo.spell
end)

-- merge it with alt y?
vim.api.nvim_create_user_command('CopyLineAbove', function(opts)
  -- local count = opts.count
  local distance = opts.line2 - opts.line1 + 1
  -- print(count, distance)
  -- print(vim.inspect(opts))
  if opts.count > 0 then
    vim.cmd('-' .. distance) -- vim.cmd("normal! " .. distance .. "k")
    vim.cmd('y') -- vim.cmd("normal! Y")
    vim.cmd('+' .. distance) -- vim.cmd("normal! " .. distance .. "j")
    vim.cmd('pu') -- vim.cmd("normal p")
    vim.cmd("normal! V'[=") -- align using "="
  end
end, { nargs = 0, count = true })
m('n', '<Leader><Leader>k', ':CopyLineAbove<CR>')

------ plugin development ------
P = function(t)
  print(vim.inspect(t))
  return t
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name, skip_setup)
  RELOAD(name)
  if not skip_setup then
    require(name).setup({})
  end
  return require(name)
end

RD = function()
  local _, session_active = require('dev-chronicles.core.state').get_session_info(true)
  RELOAD('dev-chronicles')
  require('dev-chronicles').setup({
    tracked_parent_dirs = { '~/projects/zzpackage/', '~/projects/' },
    tracked_dirs = { '~/nixos-config/' },
    runtime_opts = {
      for_dev_start_time = session_active and session_active.start_time,
    },
    min_session_time = 0,
  })
  require('dev-chronicles').start_session()
  vim.notify('Dev-chronicles reloaded')
end

m('n', '<Leader>C', '<cmd>DevChronicles<CR>')
m('n', '<Leader><Leader>c', RD)

m('n', '<Leader>rr', function()
  local cmd = 'ruff check --output-format=json ' .. vim.fn.getcwd()
  local output = vim.fn.system(cmd)

  local ok, diagnostics = pcall(vim.json.decode, output)
  if not ok then
    vim.notify('Failed to parse Ruff JSON output', vim.log.levels.ERROR)
    return
  end

  local qf = {}
  for _, d in ipairs(diagnostics) do
    table.insert(qf, {
      filename = d.filename,
      lnum = d.location.row,
      col = d.location.column,
      text = string.format('%s [%s]', d.message, d.code),
      type = 'E',
    })
  end

  vim.fn.setqflist(qf, 'r')
  vim.cmd('copen')
end, 'RuffQuickfix')

------ Harpoon + terminal mappings ------
-- pupulate Harpoon Commands based on the current buffer and run the first command in 1st terminal
m('n', '<Leader>m', function()
  if vim.bo.filetype == 'python' then
    vim.api.nvim_feedkeys(
      ';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdipap '
        .. vim.fn.expand('%:h')
        .. '/'
        .. vim.fn.expand('%:t')
        .. '\x1bq'
        .. ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r',
      'm',
      true
    )
  else
    vim.api.nvim_feedkeys(';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdapacargo run\x1bq', 'm', true)
  end
end)

m('n', '<Leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>')
m('n', 'ą', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
m('n', 'ś', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
m('n', 'ę', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
m('n', '<A-9>', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
m('n', '<A-0>', '<cmd>lua require("harpoon.ui").nav_file(5)<CR>')
m('n', '<A-a>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
m('n', '<Leader><Leader>m', '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')

m('n', '<A-h>', function() -- goes to the beginning of the command line. Always in insert mode
  if vim.bo.buftype == 'terminal' then
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true) -- change to :e %
    vim.cmd('b #')
  else
    vim.api.nvim_feedkeys(';lua require("harpoon.term").gotoTerminal(1)\ra', 'm', true) -- Can you go into insert mode via command -- keepjumps, also needed for C-^ -> almost equivalent to ":e #"!
  end
end)

m('n', '<A-H>', function() -- same, but does not change the original location of the cursor. Alsways in normal mode
  if vim.bo.buftype == 'terminal' then
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
    vim.cmd('e #')
  else
    vim.api.nvim_feedkeys(';lua require("harpoon.term").gotoTerminal(1)\r', 'm', true) -- Maby do that with a command since a is not needed
  end
end)

m('n', '<A-b>', function()
  if vim.bo.buftype == 'terminal' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-^>', true, false, true), 'm', true)
  else
    vim.api.nvim_feedkeys(';wa\r;lua require("harpoon.term").gotoTerminal(2)\ra', 'm', true)
  end
end)

m('n', '<A-j>', function()
  if vim.bo.buftype == 'terminal' then
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes('<c-^>', true, false, true)
        .. ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r',
      'm',
      true
    )
  else
    vim.api.nvim_feedkeys(
      ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r',
      'm',
      true
    )
  end
end)

m('i', '<A-j>', function()
  vim.api.nvim_feedkeys(
    '\x1b' .. ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r',
    'm',
    true
  )
end)

m(
  'n',
  '<Leader><Leader>1',
  function() -- TODO that type of thing can be done with leader A-1 etc since A-1 is on the keyboard
    if vim.bo.buftype == 'terminal' then
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<C-^>', true, false, true)
          .. ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r',
        'm',
        true
      )
    else
      vim.api.nvim_feedkeys(
        ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r',
        'm',
        true
      )
    end
  end
)

m('t', '<Esc>', '<C-\\><C-n>')
m('t', '<C-u>', '<C-\\><C-N><C-u>')
m('t', '<A-k>', '<C-\\><C-N>k')
m('t', '<A-7>', '<C-\\><C-N>gT')
m('t', '<A-8>', '<C-\\><C-N>gt')

m('t', 'ą', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
m('t', 'ś', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
m('t', 'ę', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
m('t', '<A-9>', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
m('t', '<A-0>', '<cmd>lua require("harpoon.ui").nav_file(5)<CR>')

m('t', '<A-h>', function()
  if vim.fn.bufnr('#') == vim.fn.bufnr('%') then
    vim.cmd('Oil')
  else
    vim.cmd('b #') -- vim.api.nvim_feedkeys("\x1b" .. vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
  end
end)

m('t', '<A-b>', function()
  if vim.fn.bufnr('#') == vim.fn.bufnr('%') then
    vim.cmd('Oil')
  else
    vim.cmd('b #')
  end
end)

m('t', '<A-j>', function()
  vim.api.nvim_input('<Esc>') -- nvim_feedkeys("\x1b") -- vim.cmd("stopinsert") -- vim.api.nvim_command("stopinsert")
  vim.cmd('buffer #') -- toggle previous buffer to preserve previous file if called from terminal different than terminal 1
  vim.cmd('buffer #') -- here same as require("harpoon.term").gotoTerminal(1) or nvim_feedkeys + vim.api.nvim_replace_termcodes("<c-^>", true, false, true)
  require('harpoon.term').sendCommand(1, 1)
  vim.api.nvim_input('a\r') -- vim.cmd("startinsert") and vim.api.nvim_command("startinsert") did not work properly
end)

-- TODO
-- m("t", "<A-1>", function()
--     vim.api.nvim_feedkeys("\x1b" ..
--     vim.api.nvim_replace_termcodes("<c-^>", true, false, true) ..
--     ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r', "m", true)
-- end)

m('t', 'ł', '<CMD>e ../.dev/notes.md<CR>')
m('n', 'ł', function()
  if vim.fn.expand('%') ~= '../.dev/notes.md' then
    vim.cmd('e ../.dev/notes.md')
  else
    local prev_buf_name = vim.fn.bufname('#')
    vim.cmd('b #')
    if prev_buf_name:match('^term') then
      vim.cmd('startinsert')
    end
  end
end)

----- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
