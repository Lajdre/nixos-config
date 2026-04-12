#!/usr/bin/env bash

# Initialize the system folder structure and ensure all personal Neovim
# plugins exist.

set -euo pipefail

FISH_CLONE="$HOME/.config/scripts/clone.fish"

DIRS=(
  "$HOME/cave/walls"
  "$HOME/cave/vault"
  "$HOME/cave/kkk"
  "$HOME/projects"
  "$HOME/projects/zzpackage"
)

for dir in "${DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "created: $dir"
  fi
done

echo ""
echo "Clone repos via:"
echo "  1) SSH"
echo "  2) HTTP"
read -rp "Choice [1/2]: " protocol_choice

repo_url() {
  local name="$1"
  if [ "$protocol_choice" = "2" ]; then
    echo "https://github.com/Lajdre/${name}.git"
  else
    echo "git@github.com:Lajdre/${name}.git"
  fi
}

REPOS=(
  "dev-chronicles.nvim"
  "buffjump.nvim"
  "kiss-sessions.nvim"
  "kiss-intro.nvim"
)

for repo in "${REPOS[@]}"; do
  repo_dir="$HOME/projects/$repo/"

  if [ ! -d "$repo_dir" ]; then
    url=$(repo_url "$repo")
    fish "$FISH_CLONE" "$url"
    echo "created: $repo_dir"
  fi
done
