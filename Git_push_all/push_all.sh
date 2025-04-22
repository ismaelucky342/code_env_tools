#!/bin/bash

# Define colors for output
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

# Get current working directory
start_dir=$(pwd)

# Get timestamp for default commit message
timestamp=$(date +"%d-%m-%Y %H:%M:%S")

# Determine commit message (first argument, if not empty and not a folder)
if [[ -n "$1" && ! -d "$1" ]]; then
  commit_msg="$1"
  shift  # Remove the message from the argument list
else
  commit_msg="Commit: $timestamp"
fi

# Determine which folders to process
repo_paths=()

if [ $# -eq 0 ]; then
  echo -e "${CYAN}🔍 Searching for all repositories...${RESET}"
  mapfile -t repo_paths < <(find "$start_dir" -type d -name ".git" | xargs -n1 dirname)
else
  echo -e "${CYAN}🔍 Searching for repositories in specific folders...${RESET}"
  for path in "$@"; do
    if [ -d "$path" ]; then
      mapfile -t found < <(find "$path" -type d -name ".git" | xargs -n1 dirname)
      repo_paths+=("${found[@]}")
    else
      echo -e "${RED}⚠️ Folder not found: $path${RESET}"
    fi
  done
fi

echo -e "${CYAN}🔄 Processing repositories...${RESET}"

for repo_dir in "${repo_paths[@]}"; do
  if [[ ! -d "$repo_dir/.git" ]]; then
    echo -e "${RED}❌ Not a git repository: $repo_dir${RESET}"
    continue
  fi

  if [[ "$repo_dir" == *"git_env_tools"* ]]; then
    echo -e "${YELLOW}⚠️ Skipping: $repo_dir${RESET}"
    continue
  fi

  echo -e "${YELLOW}📂 Processing: $repo_dir${RESET}"
  cd "$repo_dir" || continue

  git add .

  if git commit -m "$commit_msg"; then
    echo -e "${GREEN}✅ Commit successful!${RESET}"
  else
    echo -e "${YELLOW}⚠️ Nothing to commit.${RESET}"
  fi

  if git push; then
    echo -e "${GREEN}🚀 Push successful!${RESET}"
  else
    echo -e "${RED}❌ Push failed!${RESET}"
  fi

  cd - > /dev/null || exit
done

echo -e "${GREEN}🎉 All repositories are up to date.${RESET}"
