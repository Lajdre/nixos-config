#!/usr/bin/env fish

# Clone git repos as bare with optional worktree.
# Flags: b=blank (no worktree), z=zzpackage dir, m=use main branch

if test (count $argv) -lt 1
  echo "Usage: clone <repository-url> [b] [z] [m]"
  return 1
end

set repo_url $argv[1]

set repo_name (basename $repo_url .git)

set flags (string split "" -- (string join "" -- $argv[2..]))

set base_dir ~/projects

if contains z $flags
  set base_dir ~/projects/zzpackage
end

set target_dir $base_dir/$repo_name/.gitt

git clone --bare $repo_url $target_dir

if test $status -ne 0
  echo "Failed to clone $repo_url"
  return 1
else
  echo "Cloned successfully ($repo_name)"
end

set curr_wtree_file (dirname $target_dir)/.curr_wtree

if not contains b $flags
  set branch master
  if contains m $flags
    set branch main
  end

  echo "Adding worktree..."
  cd $target_dir
  git worktree add ../$branch $branch

  if test $status -eq 0
    echo "Worktree added at ../$branch"
    echo $branch > $curr_wtree_file
  else
    echo "Failed to add worktree"
    echo "." > $curr_wtree_file
    return 1
  end
else
  echo "Blank mode enabled. No worktree added."
  echo "." > $curr_wtree_file
end

cd (dirname $target_dir); and ls
