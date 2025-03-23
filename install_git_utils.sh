#!/bin/bash

# Nombre del repositorio y carpeta destino
REPO_URL="https://github.com/ismaelucky342/git_env_tools.git"
FOLDER_NAME="git_env_tools"

# Descargar el repositorio
if [ ! -d "$FOLDER_NAME" ]; then
    echo "🚀 Clonando el repositorio..."
    git clone "$REPO_URL"
else
    echo "⚡ El repositorio ya existe. Actualizando..."
    cd "$FOLDER_NAME" && git pull && cd ..
fi

# Asignar permisos de ejecución a todos los scripts
echo "🔧 Asignando permisos de ejecución a los scripts..."
chmod +x Git_*/*.sh

# Añadir los alias a ~/.bashrc o ~/.zshrc
SHELL_CONFIG="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

echo "🔗 Añadiendo alias a $SHELL_CONFIG..."

# Alias para cada script
echo "
# Git utils aliases
alias gitfix='bash $HOME/$FOLDER_NAME/Git_fix_all/pull_merge_rebase_fix.sh'
alias pullall='bash $HOME/$FOLDER_NAME/Git_pull_all/pull_all.sh'
alias pushall='bash $HOME/$FOLDER_NAME/Git_push_all/push_all.sh'
alias gittree='bash $HOME/$FOLDER_NAME/Git_tree/git_tree.sh'
" >> "$SHELL_CONFIG"

# Aplicar los cambios de configuración
echo "🔄 Aplicando cambios a la configuración del shell..."
source "$SHELL_CONFIG"

echo "✅ ¡Todo listo! Los alias han sido añadidos y los scripts son ejecutables."
