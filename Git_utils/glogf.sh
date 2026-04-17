#!/bin/bash
# Busca una palabra en los logs de todos los repos
if [ -z "$1" ]; then
  echo "Uso: glogf <palabra>"; exit 1
fi
find . -type d -name ".git" | while read d; do
  repo=$(dirname "$d")
  echo "\n📁 $repo"
  git -C "$repo" log --oneline --all | grep --color=always "$1"
  echo "----------------------"
done
