#!/bin/bash

# GitHub username
USER_GITHUB="$1"

# Check if a username has been provided
if [ -z "$USER_GITHUB" ]; then
    echo "❌ ERROR: Please provide a GitHub username."
    exit 1
fi

# Create a folder for the repositories if it doesn't exist
DEST_FOLDER="$HOME/$USER_GITHUB-repos"
mkdir -p "$DEST_FOLDER"
cd "$DEST_FOLDER" || exit 1

# Get the list of public repositories of the user using the GitHub API
echo "🚀 Fetching the list of GitHub repositories for user $USER_GITHUB..."
REPOS=$(curl -s "https://api.github.com/users/$USER_GITHUB/repos?per_page=100" | jq -r '.[].clone_url')

# Check if a list of repositories was obtained
if [ -z "$REPOS" ]; then
    echo "❌ ERROR: No public repositories found for user $USER_GITHUB."
    exit 1
fi

# Clone all repositories
echo "🚀 Cloning GitHub repositories..."
for REPO in $REPOS; do
    git clone "$REPO"
done

echo "✅ All repositories have been cloned into $DEST_FOLDER."
