#!/bin/bash

# Repository URL and destination folder
REPO_URL="https://github.com/ismaelucky342/git_env_tools.git"
FOLDER_NAME="git_env_tools"

# Download the repository
if [ ! -d "$FOLDER_NAME" ]; then
    echo "🚀 Cloning the repository..."
    git clone "$REPO_URL"
else
    echo "⚡ The repository already exists. Updating..."
    cd "$FOLDER_NAME" && git pull && cd ..
fi

# Grant execution permissions to all scripts
echo "🔧 Granting execution permissions to the scripts..."
cd "$FOLDER_NAME" || exit 1  # Ensure we are in the correct folder
chmod +x Git_*/*.sh
cd ..

# Add aliases to ~/.bashrc or ~/.zshrc
SHELL_CONFIG="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

echo "🔗 Adding aliases to $SHELL_CONFIG..."

# Aliases for each script
echo "
# Git utils aliases
alias git-fix='bash $HOME/$FOLDER_NAME/Git_fix_all/pull_merge_rebase_fix.sh'
alias git-pull-all='bash $HOME/$FOLDER_NAME/Git_pull_all/pull_all.sh'
alias git-push-all='bash $HOME/$FOLDER_NAME/Git_push_all/push_all.sh'
alias git-tree='bash $HOME/$FOLDER_NAME/Git_tree/git_tree.sh'
alias git-info='bash $HOME/$FOLDER_NAME/Git_info/git_info.sh'
alias git-utils-uninstall='bash $HOME/git_env_tools/git-utils-uninstall.sh'
" >> "$SHELL_CONFIG"

# Apply the configuration changes
echo "🔄 Applying changes to the shell configuration..."
source "$SHELL_CONFIG"  # Apply the aliases immediately

echo "✅ All set! The aliases have been added and the scripts are executable."
echo "🚀 Happy coding! 🚀"