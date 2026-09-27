{ config, pkgs, ... }:
let
  treesitterWithGrammars = (
    pkgs.vimPlugins.nvim-treesitter.withPlugins (
      p: with p; [
        python
        c
        cpp
        lua
        rust
        bash
        typescript
        tsx
        sql
        nix
        markdown
        markdown_inline
        regex
        vimdoc
        vim
        fish
        toml
        typst
        xml
      ]
    )
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
