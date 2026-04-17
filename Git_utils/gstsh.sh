#!/bin/bash
# Aplica git stash en todos los repositorios
find . -type d -name ".git" | while read d; do
  repo=$(dirname "$d")
  echo "\n📁 $repo"
  git -C "$repo" stash
  echo "----------------------"
done
