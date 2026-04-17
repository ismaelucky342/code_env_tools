#!/bin/bash
# Crea un tag de release y lo sube al remoto
if [ -z "$1" ]; then
  echo "Uso: gtag <versión>"; exit 1
fi
git tag "$1"
git push origin "$1"
