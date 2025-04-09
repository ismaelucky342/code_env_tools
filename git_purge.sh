#!/bin/bash

echo "🚨 Purging git_env_tools and Neovim installation..."

# Detect shell configuration file
if [[ "$SHELL" == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
else
    SHELL_CONFIG="$HOME/.bashrc"
fi

# Remove specific aliases related to git_env_tools
echo "🧹 Removing specific aliases from $SHELL_CONFIG..."
sed -i '/alias gfix=/d' "$SHELL_CONFIG"
sed -i '/alias gpurge=/d' "$SHELL_CONFIG"
sed -i '/alias gpull=/d' "$SHELL_CONFIG"
sed -i '/alias gclone=/d' "$SHELL_CONFIG"
sed -i '/alias gpush=/d' "$SHELL_CONFIG"
sed -i '/alias gclean=/d' "$SHELL_CONFIG"
sed -i '/alias gtree=/d' "$SHELL_CONFIG"
sed -i '/alias ginfo=/d' "$SHELL_CONFIG"
sed -i '/alias snvim=/d' "$SHELL_CONFIG"
sed -i '/alias snvimp=/d' "$SHELL_CONFIG"
sed -i '/alias snvima=/d' "$SHELL_CONFIG"
sed -i '/alias senv=/d' "$SHELL_CONFIG"
sed -i '/alias gpurge=/d' "$SHELL_CONFIG"

# Remove execution permissions from git_env_tools scripts
echo "🔧 Removing execution permissions from git_env_tools scripts..."
chmod -x "$HOME/git_env_tools"/g*/*.sh 2>/dev/null

# Delete git_env_tools repository folder
echo "🗑️ Removing git_env_tools repository folder..."
rm -rf "$HOME/git_env_tools"

# Remove Neovim binaries, configs, and data
echo "🗑️ Removing Neovim and its configuration..."
rm -rf "$HOME/.config/nvim" "$HOME/.local/share/nvim" "$HOME/.local/bin/nvim"

# Reload shell configuration
echo "🔄 Reloading shell configuration..."
source "$SHELL_CONFIG"

echo "✅ Purge complete! All traces of git_env_tools and Neovim have been removed."
