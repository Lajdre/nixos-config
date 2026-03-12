vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 0
vim.opt_local.shiftwidth = 0
vim.api.nvim_buf_set_keymap(0, 'i', 'qp', 'print()<left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', '<a-q>p', 'print("")<left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', 'qfp', 'print(f"{=}")<left><left><left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', 'qffp', 'print(f"}")<left><left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', ';', '<End>:<CR>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', 'q;', ';', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'x', '<Leader>cp', ':g/print/s/^/#/\r', { noremap = true }) -- comment all lines starting with print
vim.api.nvim_buf_set_keymap(0, 'i', 'qt', '# TODO: ', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', 'qm', 'if __name__ == "__main__":<CR><Tab>main()<Esc>', { noremap = true })
