#!/bin/bash

print_usage() {
    echo "📘 USAGE:"
    echo "  gclone <user> <all>         Clone all public repositories of the user"
    echo "  gclone <user> <keyword>     Search by keyword and choose which repositories to clone"
    echo "  gclone <info>               Show this information"
}

# If no arguments are provided or help is requested
if [ $# -eq 0 ] || [ "$1" == "info" ] || [ "$1" == "--help" ]; then
    print_usage
    exit 0
fi

USER_GITHUB="$1"
KEYWORD="$2"

if [ -z "$USER_GITHUB" ] || [ -z "$KEYWORD" ]; then
    echo "❌ ERROR: You must specify a user and a keyword or 'all'."
    print_usage
    exit 1
fi

DEST_FOLDER="$HOME/${USER_GITHUB}-repos"
mkdir -p "$DEST_FOLDER"
cd "$DEST_FOLDER" || exit 1

echo "🚀 Fetching repository list for $USER_GITHUB..."
REPOS_JSON=$(curl -s "https://api.github.com/users/$USER_GITHUB/repos?per_page=100")

# Manual parsing without jq
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
    echo "❌ ERROR: No public repositories found for $USER_GITHUB."
    exit 1
fi

if [[ "$KEYWORD" == "all" ]]; then
    echo "📦 Cloning all repositories of $USER_GITHUB..."
    for url in "${URLS[@]}"; do
        echo "📥 Cloning $url..."
        git clone "$url"
    done
    echo "✅ All repositories have been cloned into $DEST_FOLDER."
    exit 0
fi

# Filter by approximate match (case insensitive)
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
    echo "🔍 No repositories found matching '$KEYWORD'."
    exit 0
fi

echo "🔎 Repositories found:"
for i in "${!MATCHED_NAMES[@]}"; do
    echo "  [$i] ${MATCHED_NAMES[$i]}"
done

echo -n "👉 Enter the numbers of the repositories you want to clone (separated by space): "
read -r CHOICES

for choice in $CHOICES; do
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -lt "${#MATCHED_NAMES[@]}" ]; then
        echo "📥 Cloning ${MATCHED_NAMES[$choice]}..."
        git clone "${MATCHED_URLS[$choice]}"
    else
        echo "⚠️ Invalid index: $choice"
    fi
done

echo "✅ Cloning completed. Repositories cloned into $DEST_FOLDER."
