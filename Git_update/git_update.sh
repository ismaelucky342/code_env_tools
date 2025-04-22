#!/bin/bash

REPO_DIR="$HOME/code_env_tools"
REPO_URL="https://github.com/ismaelucky342/code_env_tools.git"

# Si no existe, clónalo
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "📦 Clonando el repositorio..."
    git clone "$REPO_URL" "$REPO_DIR"
    exit 0
fi

cd "$REPO_DIR" || { echo "❌ No se pudo acceder al directorio del repositorio."; exit 1; }

echo "🔄 Buscando cambios remotos..."
git remote update > /dev/null 2>&1

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [ "$LOCAL" = "$REMOTE" ]; then
    echo "✅ El repositorio ya está actualizado."
elif [ "$LOCAL" = "$BASE" ]; then
    echo "⬇️ Hay cambios nuevos. Actualizando..."
    git pull --rebase
elif [ "$REMOTE" = "$BASE" ]; then
    echo "⬆️ El repositorio local está por delante del remoto."
else
    echo "⚠️ El repositorio local y remoto han divergido. Revisa manualmente."
fi
