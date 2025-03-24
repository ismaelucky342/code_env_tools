#!/bin/bash

echo "🚨 Purging git_env_tools and Neovim installation..."

# Detect shell configuration file
if [[ "$SHELL" == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
else
    SHELL_CONFIG="$HOME/.bashrc"
fi

# Remove git- aliases
echo "🧹 Removing git- aliases from $SHELL_CONFIG..."
sed -i '/^alias git-/d' "$SHELL_CONFIG"
sed -i '/^alias set-/d' "$SHELL_CONFIG"

# Remove execution permissions
echo "🔧 Removing execution permissions from scripts..."
chmod -x "$HOME/git_env_tools"/Git_*/*.sh 2>/dev/null

# Delete git_env_tools repository folder
echo "🗑️ Removing git_env_tools repository folder..."
rm -rf "$HOME/git_env_tools"

# Paths for Neovim
NVIM_DIR="$HOME/.local/nvim"
CONFIG_DIR="$HOME/.config/nvim"
PLUGINS_DIR="$HOME/.local/share/nvim"
BIN_DIR="$HOME/.local/bin"

# Remove Neovim installation
if [ -d "$NVIM_DIR" ]; then
    echo "🗑️ Removing Neovim..."
    rm -rf "$NVIM_DIR"
fi

# Remove Neovim configuration
if [ -d "$CONFIG_DIR" ]; then
    echo "🗑️ Removing Neovim configuration..."
    rm -rf "$CONFIG_DIR"
fi

# Remove Neovim plugins
if [ -d "$PLUGINS_DIR" ]; then
    echo "🗑️ Removing Neovim plugins..."
    rm -rf "$PLUGINS_DIR"
fi

# Remove Neovim from PATH in shell config
if grep -q "$NVIM_DIR/bin" "$SHELL_CONFIG"; then
    echo "🧹 Removing Neovim from PATH in $SHELL_CONFIG..."
    sed -i "\|export PATH=\"$NVIM_DIR/bin:\$PATH\"|d" "$SHELL_CONFIG"
fi

echo "🔄 Reloading shell configuration..."
source "$SHELL_CONFIG"

echo "✅ Purge complete! All traces of git_env_tools and Neovim have been removed."
