if vim.env.NIX_TREESITTER_PATH ~= nil then
  vim.g.nixed = 'ziomale ponad lale'
  vim.g.nix_treesitter_path = vim.env.NIX_TREESITTER_PATH
end

require('core')

if vim.env.NIX_TREESITTER_PARSERS ~= nil then -- needs to be loaded after treesitter
  vim.opt.runtimepath:append(vim.env.NIX_TREESITTER_PARSERS)
end
