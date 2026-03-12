{ ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      bind \ch backward-kill-word
      set -x FZF_DEFAULT_OPTS "--bind='ctrl-h:unix-word-rubout'"
      set -x FZF_PREVIEW_OPTS "--preview-window=right:50%:wrap"
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
      set -x DELTA_PAGER "less --mouse"
      set -x SWWW_TRANSITION_FPS 60
      set -x UV_PYTHON_DOWNLOADS "never"
      nix-your-shell fish | source
    '';

    functions = {
      c = "cd $argv; and ls";
      d = "cd ..; and ls";
      gc = ''git commit -m "$argv"'';
      clone = "source ~/.config/scripts/clone.fish $argv";
    };

    shellAliases = {
      "v" = "nvim";
      "f" = "nvim";
      "h" = "nvim .";
      "S" = "v -c 'silent LoadDefaultSession'";
      "n" = "nvim ../.dev/notes.md";
      "p" = "python3";
      "l" = "eza --icons=auto";
      "ls" = "eza --icons=auto";
      "la" = "eza -a --icons=auto";
      "lt" = "eza --icons=auto --tree";
      "ll" = "eza -lha --icons=auto --sort=name --group-directories-first";
      "cc" = "cd ~/cave/";
      "cn" = "cd ~/.config/";
      "ccd" = "cd ~/Downloads/";
      "gal" = "swayimg --gallery";
      "gall" = "swayimg --gallery --config='general.size=2200,1000'";
      "j" = "just";
      "sp" = "wl-paste | tr ' ' '_' | wl-copy";

      # Scripts
      "a" = "source ~/.config/scripts/jump.fish a";
      "s" = "source ~/.config/scripts/jump.fish s";
      "q" = "source ~/.config/scripts/jump.fish q";
      "kk" = "source ~/.config/scripts/jump.fish k";
      "K" = "source ~/.config/scripts/jump.fish K";
      "linkd" = "~/.config/scripts/setup_dev.sh";

      # NixOS
      "reb" = "sudo nixos-rebuild switch --flake ~/nixos-config";
      "nd" = "nix develop";
      "jp" = "nix develop ~/.jupyter_flake";

      # Git
      "st" = "git status";
      "ga" = "git add";
      "ga." = "git add .";
      "gp" = "git push";
      "gd" = "git diff";
      "gP" = "git pull";
      "gPf" = "git pull --no-rebase --ff-only";
      "gfiles" = "git ls-files";
      "gl" = "git log";

      # Docker
      "di" = "docker images";
      "dr" = "docker run";
      "db" = "docker build";
      "dp" = "docker ps";
      "dps" = "docker ps -a";
      "drmi" = "docker rmi";
      "drm" = "docker rm";
    };
  };
}
