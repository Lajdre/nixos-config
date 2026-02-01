return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets', 'xzbdmw/colorful-menu.nvim' },
  version = '1.*',
  build = vim.g.nixed ~= nil and 'nix run .#build-plugin' or nil,
  opts = {
    keymap = {
      preset = 'default',
      ['<C-l>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = { fallbacks = {} },
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        snippets = {
          opts = {
            friendly_snippets = true,
            extended_filetypes = {
              c = { 'cdoc' },
              cpp = { 'cppdoc' },
              lua = { 'luadoc' },
              python = { 'pydoc' },
              rust = { 'rustdoc' },
              sh = { 'shelldoc' },
            },
          },
        },
      },
      per_filetype = {
        sql = { 'snippets', 'dadbod', 'buffer' },
      },
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
      documentation = {
        auto_show = false,
      },
      menu = {
        draw = {
          columns = { { 'kind_icon' }, { 'label', gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
    keyword = {
      -- https://github.com/Saghen/blink.cmp/issues/758
      -- https://github.com/LazyVim/LazyVim/issues/5243
      -- Regex used to get the text when fuzzy matching
      -- regex = '[/*-_@]\\|\\k',
      -- After matching with regex, any characters matching this regex at the prefix will be excluded (fix luadoc completions)
      exclude_from_prefix_regex = '[,]',
    },
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    signature = { enabled = true },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
}
