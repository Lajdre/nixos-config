local o = vim.opt

o.number = true
o.relativenumber = true
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.scrolloff = 8
o.wrap = false
o.termguicolors = true
o.splitbelow = true
o.splitright = true
o.lazyredraw = true
o.wildmenu = true
o.textwidth = 0
o.sidescroll = 3
o.timeoutlen = 700
o.background = 'dark'
o.signcolumn = 'yes'
o.syntax = 'on'
o.fileencoding = 'UTF-8'
o.completeopt = 'menuone,noselect,preview'
o.shortmess:append 'IW'
o.jumpoptions:append 'stack'
o.inccommand = 'split'
o.virtualedit = 'block'
o.spelllang = { 'en', 'pl' }
o.foldlevel = 3
o.ruler = false
o.cmdheight = 0
o.showmode = false
o.laststatus = 0
o.showcmdloc = 'tabline'
o.winborder = 'rounded'
o.smarttab = true
o.expandtab = true
o.tabstop = 2
o.softtabstop = 0
o.shiftwidth = 0
o.autoindent = true
o.smartindent = true
o.list = true
o.listchars = {
  trail = '»',
  tab = '⫸_',
}

vim.g.markdown_folding = 1
vim.g.enable_autoformat = true

if vim.fn.system('uname -r'):find('WSL') then
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end
o.clipboard = 'unnamedplus'

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  command = 'set nolist',
})

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set list',
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', { -- :h vim.highlight.on_yank
  callback = function()
    vim.highlight.on_yank({ timeout = 90 }) -- higroup = 'IncSearch'
  end,
  group = highlight_group,
  pattern = '*',
})
