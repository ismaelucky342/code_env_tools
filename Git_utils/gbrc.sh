#!/bin/bash
# Borra ramas locales ya fusionadas/remotas eliminadas
git fetch --all --prune
git branch --merged | grep -v '\*' | grep -v main | xargs -r git branch -d
git remote prune origin
