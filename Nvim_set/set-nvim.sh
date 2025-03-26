#!/bin/bash

# Definir la URL del Tarball de Neovim
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"

# Directorio de instalación (puedes cambiarlo)
INSTALL_DIR="$HOME/.local/nvim"

# Crear directorio de instalación si no existe
mkdir -p "$INSTALL_DIR"

# Descargar el Tarball de Neovim
echo "Descargando Neovim..."
curl -L "$NVIM_URL" -o /tmp/nvim-linux-x86_64.tar.gz

# Verificar si la descarga fue exitosa
if [ $? -ne 0 ]; then
    echo "Error: No se pudo descargar Neovim."
    exit 1
fi

# Extraer el contenido del Tarball
echo "Extrayendo archivos..."
tar -xzvf /tmp/nvim-linux-x86_64.tar.gz -C "$INSTALL_DIR" --strip-components=1

# Verificar si la extracción fue exitosa
if [ $? -ne 0 ]; then
    echo "Error: No se pudo extraer los archivos de Neovim."
    exit 1
fi

# Agregar Neovim al PATH
echo "Agregando Neovim al PATH..."
echo "export PATH=\"$INSTALL_DIR/bin:\$PATH\"" >> "$HOME/.bashrc"
echo "export PATH=\"$INSTALL_DIR/bin:\$PATH\"" >> "$HOME/.zshrc"

# Mensaje final
echo "✅ Neovim instalado en $INSTALL_DIR"
echo "➡️  Reinicia tu terminal o ejecuta: source ~/.bashrc"
