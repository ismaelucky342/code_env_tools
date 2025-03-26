#!/bin/bash

# Definir la URL del Tarball de Neovim
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
INSTALL_DIR="$HOME/.local/nvim"

# Crear directorio de instalación
mkdir -p "$INSTALL_DIR" || { echo "❌ Error creando el directorio $INSTALL_DIR"; exit 1; }

# Descargar y extraer Neovim en un solo paso si la descarga es exitosa
echo "📥 Descargando y extrayendo Neovim..."
curl -fL "$NVIM_URL" -o /tmp/nvim.tar.gz && \
tar -xzf /tmp/nvim.tar.gz -C "$INSTALL_DIR" --strip-components=1 && \
rm /tmp/nvim.tar.gz || { echo "❌ Error durante la instalación"; exit 1; }

# Agregar Neovim al PATH si no está ya presente
SHELL_CONFIG=""
if [[ $SHELL == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ $SHELL == */bash ]]; then
    SHELL_CONFIG="$HOME/.bashrc"
else
    SHELL_CONFIG="$HOME/.profile"
fi

if ! grep -q "$INSTALL_DIR/bin" "$SHELL_CONFIG"; then
    echo "export PATH=\"$INSTALL_DIR/bin:\$PATH\"" >> "$SHELL_CONFIG"
    echo "🔧 Se agregó Neovim al PATH en $SHELL_CONFIG"
fi

echo "✅ Neovim instalado en $INSTALL_DIR"

