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
if [ $# -eq 0 ]; then
  echo -e "${CYAN}🔍 Buscando todos los repositorios...${RESET}"
  repo_paths=$(find "$start_dir" -type d -name ".git" | xargs -n1 dirname)
else
  repo_paths=("$@")
fi

echo -e "${CYAN}🔄 Procesando repositorios...${RESET}"

for repo_dir in "${repo_paths[@]}"; do
  if [[ ! -d "$repo_dir/.git" ]]; then
    echo -e "${RED}❌ No es un repositorio git: $repo_dir${RESET}"
    continue
  fi

  if [[ "$repo_dir" == *"git_env_tools"* ]]; then
    echo -e "${YELLOW}⚠️ Saltando: $repo_dir${RESET}"
    continue
  fi

  echo -e "${YELLOW}📂 Procesando: $repo_dir${RESET}"
  cd "$repo_dir" || continue

  git add .

  if git commit -m "$commit_msg"; then
    echo -e "${GREEN}✅ Commit exitoso!${RESET}"
  else
    echo -e "${YELLOW}⚠️ Nada que commitear.${RESET}"
  fi

  if git push; then
    echo -e "${GREEN}🚀 Push exitoso!${RESET}"
  else
    echo -e "${RED}❌ Fallo al hacer push!${RESET}"
  fi

  cd - > /dev/null || exit
done

echo -e "${GREEN}🎉 Todos los repositorios están actualizados.${RESET}"
