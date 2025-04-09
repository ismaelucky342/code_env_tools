#!/bin/bash

print_usage() {
    echo "📘 USAGE:"
    echo "  gclone <user> <all>         Clones all public repositories of the user"
    echo "  gclone <user> <keyword>     Clones repositories containing the keyword in their name"
    echo "  gclone <info>               Displays this information"
}

# If no arguments are provided or help is requested
if [ $# -eq 0 ] || [ "$1" == "info" ] || [ "$1" == "--help" ]; then
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

# Create destination folder
DEST_FOLDER="$HOME/${USER_GITHUB}-repos"
mkdir -p "$DEST_FOLDER"
cd "$DEST_FOLDER" || exit 1

echo "🚀 Fetching repository list for $USER_GITHUB..."
# Fetch full JSON of repositories
REPOS_JSON=$(curl -s "https://api.github.com/users/$USER_GITHUB/repos?per_page=100")

# Extract name and HTTPS URL of each repository
NAMES=($(echo "$REPOS_JSON" | grep -oP '"name": "\K[^"]+'))
URLS=($(echo "$REPOS_JSON" | grep -oP '"clone_url": "\K[^"]+'))

if [ ${#NAMES[@]} -eq 0 ]; then
    echo "❌ ERROR: No public repositories found for $USER_GITHUB."
    exit 1
fi

echo "📦 Repositories found: ${#NAMES[@]}"

MATCHED=0

for i in "${!NAMES[@]}"; do
    REPO_NAME="${NAMES[$i]}"
    REPO_URL="${URLS[$i]}"
    if [ "$KEYWORD" == "all" ] || [[ "$REPO_NAME" == *"$KEYWORD"* ]]; then
        echo "📥 Cloning $REPO_NAME..."
        git clone "$REPO_URL"
        ((MATCHED++))
    fi
done

if [ "$MATCHED" -eq 0 ]; then
    echo "🔍 No repositories found matching '$KEYWORD'."
else
    echo "✅ $MATCHED repositories cloned into $DEST_FOLDER."
fi
