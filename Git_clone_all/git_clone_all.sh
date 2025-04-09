#!/bin/bash

print_usage() {
    echo "📘 USAGE:"
    echo "  gclone <user> <all>         Clones all public repositories of the user"
    echo "  gclone <user> <keyword>     Searches repositories matching keyword, then lets you choose"
    echo "  gclone <info>               Displays this information"
}

# Show help if needed
if [ $# -eq 0 ] || [[ "$1" == "info" ]] || [[ "$1" == "--help" ]]; then
    print_usage
    exit 0
fi

USER_GITHUB="$1"
KEYWORD="$2"

if [ -z "$USER_GITHUB" ] || [ -z "$KEYWORD" ]; then
    echo "❌ ERROR: You must provide a user and a keyword or 'all'"
    print_usage
    exit 1
fi

DEST_FOLDER="$HOME/${USER_GITHUB}-repos"
mkdir -p "$DEST_FOLDER"
cd "$DEST_FOLDER" || exit 1

echo "🚀 Fetching repository list for $USER_GITHUB..."
REPOS_JSON=$(curl -s "https://api.github.com/users/$USER_GITHUB/repos?per_page=100")

# Extract names and clone URLs
NAMES=($(echo "$REPOS_JSON" | grep -oP '"name": "\K[^"]+'))
URLS=($(echo "$REPOS_JSON" | grep -oP '"clone_url": "\K[^"]+'))

if [ ${#NAMES[@]} -eq 0 ]; then
    echo "❌ ERROR: No public repositories found for $USER_GITHUB."
    exit 1
fi

# If keyword is "all", clone everything
if [ "$KEYWORD" == "all" ]; then
    echo "📥 Cloning all ${#NAMES[@]} repositories..."
    for URL in "${URLS[@]}"; do
        git clone "$URL"
    done
    echo "✅ All repositories cloned into $DEST_FOLDER."
    exit 0
fi

# Search for keyword in repo names
MATCHED_NAMES=()
MATCHED_URLS=()
for i in "${!NAMES[@]}"; do
    if [[ "${NAMES[$i],,}" == *"${KEYWORD,,}"* ]]; then
        MATCHED_NAMES+=("${NAMES[$i]}")
        MATCHED_URLS+=("${URLS[$i]}")
    fi
done

if [ ${#MATCHED_NAMES[@]} -eq 0 ]; then
    echo "🔍 No repositories found matching '$KEYWORD'."
    exit 1
fi

# Show matched repos to user
echo "🔎 Repositories matching '$KEYWORD':"
for i in "${!MATCHED_NAMES[@]}"; do
    printf "  [%d] %s\n" "$i" "${MATCHED_NAMES[$i]}"
done

# Ask user which ones to clone
echo -n "👉 Enter the numbers of the repositories to clone (separated by spaces): "
read -r choices

for choice in $choices; do
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -lt "${#MATCHED_NAMES[@]}" ]; then
        echo "📥 Cloning ${MATCHED_NAMES[$choice]}..."
        git clone "${MATCHED_URLS[$choice]}"
    else
        echo "⚠️ Invalid choice: $choice"
    fi
done

echo "✅ Cloning completed. Repositories cloned into $DEST_FOLDER."