#!/bin/bash

echo "🚨 Purging git_env_tools installation..."

# Detect shell configuration file
if [[ "$SHELL" == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
else
    SHELL_CONFIG="$HOME/.bashrc"
fi

# Remove aliases
echo "🧹 Removing aliases from $SHELL_CONFIG..."
sed -i '/# Git utils aliases/,+7d' "$SHELL_CONFIG"

# Remove execution permissions
echo "🔧 Removing execution permissions from scripts..."
chmod -x "$HOME/git_env_tools"/Git_*/*.sh 2>/dev/null

# Delete repository folder
echo "🗑️ Removing repository folder..."
rm -rf "$HOME/git_env_tools"

# Apply changes
echo "🔄 Reloading shell configuration..."
source "$SHELL_CONFIG"

echo "✅ Purge complete! All traces of git_env_tools have been removed."
