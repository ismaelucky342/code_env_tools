#!/bin/bash
# Cambia a un commit específico o muestra la lista numerada de commits si no se pasa argumento

if [ -z "$1" ]; then
  echo "Lista de commits recientes (número : hash : mensaje):"
  git log --oneline | nl -v 1
  exit 0
fi

# Si el argumento es un número, buscar el hash correspondiente
if [[ "$1" =~ ^[0-9]+$ ]]; then
  HASH=$(git log --oneline | sed -n "${1}p" | awk '{print $2}')
  if [ -z "$HASH" ]; then
    echo "Número de commit inválido."
    exit 1
  fi
else
  HASH="$1"
fi

echo "Haciendo checkout a $HASH..."
git checkout "$HASH"
