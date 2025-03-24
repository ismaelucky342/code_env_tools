#!/bin/bash

FOLDER_NAME="git_env_tools"
SHELL_CONFIG="$HOME/.bashrc"

if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

echo "🔧 Eliminando los alias de $SHELL_CONFIG..."

sed -i '/# Git utils aliases/,+6d' "$SHELL_CONFIG"

echo "🔄 Aplicando cambios a la configuración del shell..."
source "$SHELL_CONFIG"

echo "🔧 Eliminando los permisos de ejecución a los scripts..."
chmod -x "$FOLDER_NAME"/Git_*/*.sh

echo "❌ El repositorio '$FOLDER_NAME' no será eliminado. Si quieres eliminarlo, debes hacerlo manualmente."
echo "✅ ¡Desinstalación completa! Los alias y los permisos de ejecución han sido eliminados."
