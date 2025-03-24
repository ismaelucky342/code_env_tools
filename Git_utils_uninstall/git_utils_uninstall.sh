#!/bin/bash

# Nombre del repositorio y carpeta destino
FOLDER_NAME="git_env_tools"
SHELL_CONFIG="$HOME/.bashrc"

# Detectar si estamos usando Zsh en lugar de Bash
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

# Eliminar los alias relacionados de .bashrc o .zshrc
echo "🔧 Eliminando los alias de $SHELL_CONFIG..."

sed -i '/# Git utils aliases/,+5d' "$SHELL_CONFIG"

# Aplicar los cambios a la configuración del shell
echo "🔄 Aplicando cambios a la configuración del shell..."
source "$SHELL_CONFIG"

# Eliminar los permisos de ejecución de los scripts
echo "🔧 Eliminando los permisos de ejecución a los scripts..."
chmod -x "$FOLDER_NAME"/Git_*/*.sh

# Eliminar el repositorio si se desea
echo "❌ El repositorio '$FOLDER_NAME' no será eliminado. Si quieres eliminarlo, debes hacerlo manualmente."

echo "✅ ¡Desinstalación completa! Los alias y los permisos de ejecución han sido eliminados."
