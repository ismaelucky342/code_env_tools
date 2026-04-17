#!/bin/bash
# Muestra el estado de todos los repositorios en subcarpetas
find . -type d -name ".git" | while read d; do
  repo=$(dirname "$d")
  echo "\n📁 $repo"
  git -C "$repo" status -sb
  echo "----------------------"
done
