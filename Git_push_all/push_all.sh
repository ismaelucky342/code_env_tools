#!/bin/bash

# Define colors for output
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

# Store the current working directory
start_dir=$(pwd)

# Get the current date and time for the commit message
timestamp=$(date +"%d-%m-%Y %H:%M:%S")

echo -e "${CYAN}🔄 Updating and pushing all repositories...${RESET}"

# Find all subdirectories that contain a .git folder (indicating a Git repo)
find "$start_dir" -type d -name ".git" | while read gitdir; do
  repo_dir=$(dirname "$gitdir")  # Get the parent directory (actual repo)

  # Skip the git_env_tools directory
  if [[ "$repo_dir" == *"git_env_tools"* ]]; then
    echo -e "${YELLOW}⚠️ Skipping repository: ${repo_dir}${RESET}"
    continue
  fi

  echo -e "${YELLOW}📂 Processing repository: ${repo_dir}${RESET}"

  cd "$repo_dir" || exit  # Change into the repository directory

  # Add all changes
  git add .

  # Commit changes with timestamp
  if git commit -m "Commit: $timestamp"; then
    echo -e "${GREEN}✅ Committed successfully!${RESET}"
  else
    echo -e "${YELLOW}⚠️ Nothing to commit.${RESET}"
  fi

  # Push to remote repository
  if git push; then
    echo -e "${GREEN}🚀 Pushed successfully!${RESET}"
  else
    echo -e "${RED}❌ Push failed!${RESET}"
  fi

  cd - > /dev/null || exit  # Return to the starting directory (suppress output)
done

echo -e "${GREEN}🎉 All repositories are up to date!${RESET}"