{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # utils
    rip2
    btop
    wget
    unzip
    fzf
    fastfetch
    syncthing
    bat
    eza
    tree
    tokei
    jq
    ripgrep
    fd
    calcurse
    ffmpeg
    py7zr
    ripdrag
    obs-studio
    dysk
    tree-sitter
    nix-your-shell

    # dev
    pyright
    lua-language-server
    stylua
    uv
    nixfmt-rfc-style
    devenv
    podman-compose
    # rust-analyzer-unwrapped
    # nodejs_22
    # gh
    # quarto

    # build-essential
    cmake
    gnumake
    gcc
  ];
}
