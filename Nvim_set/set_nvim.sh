#!/bin/bash

# Obtener la ruta donde está este script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOCKERFILE="$SCRIPT_DIR/Dockerfile.nvim"
IMAGE_NAME="nvim-env"

echo "🔧 Construyendo imagen Docker '$IMAGE_NAME' con Neovim y plugins..."
docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" "$SCRIPT_DIR" || {
    echo "❌ Error al construir la imagen Docker"
    exit 1
}

echo "✅ Imagen Docker '$IMAGE_NAME' creada correctamente."

echo "🚀 Para usar Neovim, ejecuta:"
echo "    docker run -it --rm $IMAGE_NAME"
