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
  home.sessionVariables = {
    NIX_TREESITTER_PARSERS = "${treesitter-parsers}";
    NIX_TREESITTER_PATH = "${treesitterWithGrammars}";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.file.".config/nvim/" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/nvim/";
    recursive = true;
  };
}
