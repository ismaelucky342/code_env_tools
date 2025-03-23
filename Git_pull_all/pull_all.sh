#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

start_dir=$(pwd)

echo -e "${CYAN}🔄 Fixing ORIG_HEAD and pulling latest changes from all repositories...${RESET}"

# Buscar todos los subdirectorios que contengan un repositorio de git y arreglar ORIG_HEAD antes del pull
find "$start_dir" -type d -name ".git" | while read gitdir; do
  repo_dir=$(dirname "$gitdir")
  echo -e "${YELLOW}📂 Processing repository: ${repo_dir}${RESET}"

  cd "$repo_dir" || exit

  # Reparar ORIG_HEAD si está roto
  if [ -f .git/ORIG_HEAD ]; then
    rm -f .git/ORIG_HEAD
    echo -e "${CYAN}🛠 Fixed ORIG_HEAD${RESET}"
  fi

  # Intentar hacer git pull
  if git pull; then
    echo -e "${GREEN}✅ Pulled successfully!${RESET}"
  else
    echo -e "${RED}❌ Pull failed!${RESET}"
  fi

  cd - > /dev/null || exit
done

echo -e "${GREEN}🎉 All repositories are up to date!${RESET}"