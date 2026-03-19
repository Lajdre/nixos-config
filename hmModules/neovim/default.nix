{ config, pkgs, ... }:
let
  treesitterWithGrammars = (
    pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
      p.python
      p.c
      p.cpp
      p.lua
      p.rust
      p.bash
      p.typescript
      p.tsx
      p.sql
      p.nix
      p.markdown
      p.markdown_inline
      p.regex
      p.vimdoc
      p.vim
      p.fish
      p.toml
      p.typst
      p.xml
    ])
  );

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    withRuby = true;
    withNodeJs = false;

    plugins = [
      treesitterWithGrammars
    ];
  };

  home.file.".config/nvim/" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/nvim/";
    recursive = true;
  };

  home.file.".config/nvim-treesitter-parsers/nvim-treesitter-parsers.lua".text = ''
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  # Treesitter is configured as a locally developed module in lazy.nvim
  # We put it where lazy.nvim expects locally developed plugins (dev:path)
  home.file.".config/nixed_nvim/nvim-treesitter/" = {
    source = treesitterWithGrammars;
    recursive = true;
  };

  home.sessionVariables = {
    NIXED_NVIM = "ziomale ponad lale";
  };
}
