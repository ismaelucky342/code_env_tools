#!/bin/bash

# Define color codes for output formatting
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

# Save the starting directory
start_dir=$(pwd)

# Print a message indicating the start of the process
echo -e "${CYAN}🔄 Fixing ORIG_HEAD and pulling latest changes from repositories...${RESET}"

# --- Find repositories ---
repo_paths=()

# If no arguments are provided, search for all repositories in the current directory
if [ $# -eq 0 ]; then
  echo -e "${CYAN}🔍 Searching for all repositories...${RESET}"
  mapfile -t repo_paths < <(find "$start_dir" -type d -name ".git" | xargs -n1 dirname)
else
  # If arguments are provided, search for repositories in the specified directories
  echo -e "${CYAN}🔍 Searching for repositories in specific folders...${RESET}"
  for path in "$@"; do
    if [ -d "$path" ]; then
      # Find repositories in the given path and add them to the list
      mapfile -t found < <(find "$path" -type d -name ".git" | xargs -n1 dirname)
      repo_paths+=("${found[@]}")
    else
      # Print a warning if the folder is not found
      echo -e "${RED}⚠️ Folder not found: $path${RESET}"
    fi
  done
fi

# --- Process repositories ---
for repo_dir in "${repo_paths[@]}"; do
  # Print the repository being processed
  echo -e "${YELLOW}📂 Processing repository: $repo_dir${RESET}"
  cd "$repo_dir" || continue

  # If the ORIG_HEAD file exists, remove it
  if [ -f .git/ORIG_HEAD ]; then
    rm -f .git/ORIG_HEAD
    echo -e "${CYAN}🛠 Fixed ORIG_HEAD${RESET}"
  fi

  # Attempt to pull the latest changes from the repository
  if git pull; then
    echo -e "${GREEN}✅ Pull successful!${RESET}"
  else
    echo -e "${RED}❌ Pull failed!${RESET}"
  fi

  # Return to the previous directory
  cd - > /dev/null || exit
done

# Print a message indicating the process is complete
echo -e "${GREEN}🎉 All repositories are up to date!${RESET}"
