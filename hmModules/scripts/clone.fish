#!/usr/bin/env fish

# Makes a bare clone of a repo and sets up worktree workflow.
# Checks out master by default if exists on the remote, falls back to main.
#
# Usage: clone <repository-url> [flags]
#
# Flags:
#   b  blank - skip worktree setup
#   z  clone into ~/projects/zzpackage (default: ~/projects)
#   s  clone into ~/projects/zzsilent (default: ~/projects)
#   m  force main branch (default: auto-detect, prefer master)
#
# Example structure:
#   ~/projects/
#   └── repo-name/
#       ├── .gitt/        (bare repo)
#       ├── .curr_wtree   (name of the active worktree)
#       └── master/       (worktree checkout)

function log
  set_color --bold green
  echo "» $argv"
  set_color normal
end

function err
  set_color --bold red
  echo "» $argv"
  set_color normal
end

if test (count $argv) -lt 1
  log "Usage: clone <repository-url> [b] [z] [s] [m]"
  return 1
end

set repo_url $argv[1]
set repo_name (basename $repo_url .git)
set flags (string split "" -- (string join "" -- $argv[2..]))

if contains z $flags && contains s $flags
  err "Error: flags 'z' and 's' are mutually exclusive"
  return 1
end

set base_dir ~/projects
if contains z $flags
  set base_dir ~/projects/zzpackage
else if contains s $flags
  set base_dir ~/projects/zzsilent
end

set repo_dir $base_dir/$repo_name
set target_dir $repo_dir/.gitt
set curr_wtree_file $repo_dir/.curr_wtree

if test -d $repo_dir
  err "Error: directory already exists: $repo_dir"
  return 1
end

if not git clone --bare $repo_url $target_dir
  err "Failed to clone $repo_url"
  return 1
end

log "Cloned successfully ($repo_name)"

# Fix the fetch refspec (ofc)
git -C $target_dir config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git -C $target_dir fetch --quiet

if contains b $flags
  log "Blank mode enabled. No worktree added."
  echo "." > $curr_wtree_file
  cd $repo_dir; and ls
  return 0
end

if contains m $flags
  set branch main
else if git -C $target_dir show-ref --verify --quiet refs/remotes/origin/master
  set branch master
else if git -C $target_dir show-ref --verify --quiet refs/remotes/origin/main
  set branch main
else
  err "Error: neither main nor master branch found. Not setting up a worktree"
  echo "." > $curr_wtree_file
  return 1
end

log "Adding worktree..."

if not git -C $target_dir worktree add ../$branch $branch
  err "Failed to add worktree"
  echo "." > $curr_wtree_file
  return 1
end

if not git -C $target_dir branch --set-upstream-to=origin/$branch $branch
  err "Failed to set upstream for $branch."
end

log "Worktree added at ../$branch"
echo $branch > $curr_wtree_file

cd $repo_dir/$branch; and ls
