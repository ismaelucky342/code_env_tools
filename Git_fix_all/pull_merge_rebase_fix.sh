#!/bin/bash

# Define colors for output
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

# Store the current working directory
start_dir=$(pwd)

echo -e "${CYAN}🔄 Pulling, merging, rebasing, and fixing all repositories...${RESET}"

# Find all Git repositories in the current directory
find "$start_dir" -type d -name ".git" | while read gitdir; do
  repo_dir=$(dirname "$gitdir")  # Get parent directory (actual repo)

  echo -e "${YELLOW}📂 Processing repository: ${repo_dir}${RESET}"

  cd "$repo_dir" || exit  # Move into the repository directory

  # Check if inside a git repository
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo -e "${RED}⚠️ Not a valid Git repository! Skipping...${RESET}"
    cd - > /dev/null || exit
    continue
  fi

  # Ensure the working directory is clean
  if ! git diff --quiet || ! git diff --staged --quiet; then
    echo -e "${RED}⚠️ Uncommitted changes detected! Stashing temporarily...${RESET}"
    git stash push -m "Auto-stash before pull" > /dev/null
    stash_applied=true
  else
    stash_applied=false
  fi

  # Fetch latest changes
  git fetch --all --prune

  # Get current branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  # If in a detached HEAD state, reset to the default branch
  if [ "$current_branch" = "HEAD" ]; then
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    echo -e "${YELLOW}⚠️ Detached HEAD detected! Checking out ${default_branch}...${RESET}"
    git checkout "$default_branch" || exit
    current_branch="$default_branch"
  fi

  # Check if branch is tracking a remote branch
  if git rev-parse --abbrev-ref --symbolic-full-name "@{u}" > /dev/null 2>&1; then
    echo -e "${CYAN}🔄 Pulling latest changes for branch: ${current_branch}${RESET}"

    # Try rebasing first
    if git pull --rebase; then
      echo -e "${GREEN}✅ Rebase successful!${RESET}"
    else
      echo -e "${YELLOW}⚠️ Rebase failed. Trying merge instead...${RESET}"

      # If rebase fails, abort and try merging
      git rebase --abort > /dev/null 2>&1  # Abort if a rebase is in progress
      if git pull --no-rebase; then
        echo -e "${GREEN}✅ Merge successful!${RESET}"
      else
        echo -e "${RED}❌ Merge failed! Trying automatic conflict resolution...${RESET}"

        # Attempt to automatically resolve conflicts
        git merge --abort > /dev/null 2>&1  # Abort failed merges
        git reset --hard HEAD  # Reset to the last commit
        git clean -fd  # Remove untracked files

        echo -e "${YELLOW}⚠️ Merge failed! Manual intervention required.${RESET}"
      fi
    fi
  else
    echo -e "${RED}⚠️ No tracking branch found for ${current_branch}. Skipping...${RESET}"
  fi

  # Apply stashed changes if any
  if [ "$stash_applied" = true ]; then
    echo -e "${YELLOW}🔄 Restoring stashed changes...${RESET}"
    git stash pop > /dev/null
  fi

  cd - > /dev/null || exit  # Return to the starting directory
done

echo -e "${GREEN}🎉 All repositories processed successfully!${RESET}"