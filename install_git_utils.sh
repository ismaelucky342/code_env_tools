#!/bin/bash

# Repository URL and destination folder
REPO_URL="https://github.com/ismaelucky342/git_env_tools.git"
FOLDER_NAME="git_env_tools"

# Detect the shell configuration file dynamically
if [[ "$SHELL" == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
else
    SHELL_CONFIG="$HOME/.bashrc"
fi

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

# Remove old aliases from the shell configuration
echo "🧹 Cleaning up old aliases from $SHELL_CONFIG..."
sed -i '/# Git utils aliases/,+7d' "$SHELL_CONFIG"

# Add new aliases
echo "🔗 Adding aliases to $SHELL_CONFIG..."
cat <<EOF >> "$SHELL_CONFIG"

# Git utils aliases
alias git-fix='bash $HOME/$FOLDER_NAME/Git_fix_all/pull_merge_rebase_fix.sh'
alias git-pull-all='bash $HOME/$FOLDER_NAME/Git_pull_all/pull_all.sh'
alias git-push-all='bash $HOME/$FOLDER_NAME/Git_push_all/push_all.sh'
alias git-tree='bash $HOME/$FOLDER_NAME/Git_tree/git_tree.sh'
alias git-info='bash $HOME/$FOLDER_NAME/Git_info/git_info.sh'
alias git-purge='bash $HOME/$FOLDER_NAME/git_purge.sh'
EOF


# Ensure the purge script is executable
chmod +x "$FOLDER_NAME/git_purge.sh"

# Apply changes immediately
echo "🔄 Applying changes to the shell configuration..."
source "$SHELL_CONFIG"

# Verify alias availability
echo "🔍 Verifying alias availability..."
if alias git-uninstall &>/dev/null && alias git-purge &>/dev/null; then
    echo "✅ Aliases 'git-uninstall' and 'git-purge' have been successfully added!"
else
    echo "❌ ERROR: Some aliases are not available."
    echo "⚠️ Try running: source $SHELL_CONFIG and then test again."
fi

echo "✅ All set! The aliases have been added and the scripts are executable."
echo "🚀 Happy coding! 🚀"
