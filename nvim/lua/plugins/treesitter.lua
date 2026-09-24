return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  dir = vim.g.nix_treesitter_path or nil,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
