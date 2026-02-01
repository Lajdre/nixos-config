return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  dev = vim.g.nixed ~= nil,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
