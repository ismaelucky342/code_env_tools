#!/bin/bash
# Recupera archivos borrados recientemente
if [ -z "$1" ]; then
  echo "Uso: gundo <archivo>"; exit 1
fi
git checkout HEAD -- "$1"
