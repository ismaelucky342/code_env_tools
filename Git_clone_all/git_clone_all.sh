#!/bin/bash

print_usage() {
    echo "📘 USAGE:"
    echo "  gclone <user> <all>         Clona todos los repos públicos del usuario"
    echo "  gclone <user> <keyword>     Busca por palabra clave y permite elegir qué repos clonar"
    echo "  gclone <info>               Muestra esta información"
}

# Si no hay argumentos o se pide ayuda
if [ $# -eq 0 ] || [ "$1" == "info" ] || [ "$1" == "--help" ]; then
    print_usage
    exit 0
fi

USER_GITHUB="$1"
KEYWORD="$2"

if [ -z "$USER_GITHUB" ] || [ -z "$KEYWORD" ]; then
    echo "❌ ERROR: Debes indicar usuario y palabra clave o 'all'."
    print_usage
    exit 1
fi

DEST_FOLDER="$HOME/${USER_GITHUB}-repos"
mkdir -p "$DEST_FOLDER"
cd "$DEST_FOLDER" || exit 1

echo "🚀 Fetching repository list for $USER_GITHUB..."
REPOS_JSON=$(curl -s "https://api.github.com/users/$USER_GITHUB/repos?per_page=100")

# Parseo manual sin jq
NAMES=()
URLS=()
while IFS= read -r line; do
    if [[ "$line" =~ \"name\":\ \"([^\"]+)\" ]]; then
        CURRENT_NAME="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ \"clone_url\":\ \"([^\"]+)\" ]]; then
        CURRENT_URL="${BASH_REMATCH[1]}"
        NAMES+=("$CURRENT_NAME")
        URLS+=("$CURRENT_URL")
    fi
done <<< "$REPOS_JSON"

if [ ${#NAMES[@]} -eq 0 ]; then
    echo "❌ ERROR: No se encontraron repos públicos para $USER_GITHUB."
    exit 1
fi

if [[ "$KEYWORD" == "all" ]]; then
    echo "📦 Clonando todos los repos de $USER_GITHUB..."
    for url in "${URLS[@]}"; do
        echo "📥 Clonando $url..."
        git clone "$url"
    done
    echo "✅ Todos los repos han sido clonados en $DEST_FOLDER."
    exit 0
fi

# Filtrar por coincidencia aproximada (insensible a mayúsculas)
MATCHED_NAMES=()
MATCHED_URLS=()
for i in "${!NAMES[@]}"; do
    name="${NAMES[$i]}"
    url="${URLS[$i]}"
    if [[ "${name,,}" == *"${KEYWORD,,}"* ]]; then
        MATCHED_NAMES+=("$name")
        MATCHED_URLS+=("$url")
    fi
done

if [ ${#MATCHED_NAMES[@]} -eq 0 ]; then
    echo "🔍 No se encontraron repositorios que coincidan con '$KEYWORD'."
    exit 0
fi

echo "🔎 Repositorios encontrados:"
for i in "${!MATCHED_NAMES[@]}"; do
    echo "  [$i] ${MATCHED_NAMES[$i]}"
done

echo -n "👉 Introduce los números de los repos que quieres clonar (separados por espacio): "
read -r CHOICES

for choice in $CHOICES; do
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -lt "${#MATCHED_NAMES[@]}" ]; then
        echo "📥 Clonando ${MATCHED_NAMES[$choice]}..."
        git clone "${MATCHED_URLS[$choice]}"
    else
        echo "⚠️ Índice inválido: $choice"
    fi
done

echo "✅ Clonado completado. Repositorios clonados en $DEST_FOLDER."
