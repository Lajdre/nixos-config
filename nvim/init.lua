-- if vim.env.NIXED_NVIM ~= nil then
--   vim.g.nixed = 'ziomale ponad lale'
-- end
-- vim.g.nix_treesitter_parsers = vim.env.NIX_TREESITTER_PARSERS
if vim.env.NIX_TREESITTER_PATH ~= nil then
  vim.g.nixed = 'ziomale ponad lale'
  vim.g.nix_treesitter_path = vim.env.NIX_TREESITTER_PATH
end

require('core')

-- if vim.env.NIX_TREESITTER_PARSERS ~= nil then
--   vim.opt.runtimepath:append(vim.env.NIX_TREESITTER_PARSERS)
-- end
if vim.env.NIX_TREESITTER_PARSERS ~= nil then -- needs to be loaded after treesitter
  vim.opt.runtimepath:append(vim.env.NIX_TREESITTER_PARSERS)
end

-- if vim.g.nixed ~= nil then -- needs to be loaded after treesitter
--   package.path = package.path .. ';' .. vim.fn.stdpath('config') .. '-treesitter-parsers/?.lua'
--   require('nvim-treesitter-parsers')
-- end
