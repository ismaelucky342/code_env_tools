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
sed -i '/# Git utils aliases/,+5d' "$SHELL_CONFIG"

# Add new aliases
echo "🔗 Adding aliases to $SHELL_CONFIG..."
cat <<EOF >> "$SHELL_CONFIG"

# Git utils aliases
alias gf='bash $HOME/$FOLDER_NAME/Git_fix_all/pull_merge_rebase_fix.sh'
alias gpurge='bash $HOME/$FOLDER_NAME/git_purge.sh'
alias gpa='bash $HOME/$FOLDER_NAME/Git_pull_all/pull_all.sh'
alias gca='bash $HOME/$FOLDER_NAME/Git_clone_all/git_clone_all.sh'
alias gpush='bash $HOME/$FOLDER_NAME/Git_push_all/push_all.sh'
alias gda='bash $HOME/$FOLDER_NAME/Git_delete_repos/git_delete_repos.sh'
alias gtree='bash $HOME/$FOLDER_NAME/Git_tree/git_tree.sh'
alias ginfo='bash $HOME/$FOLDER_NAME/Git_info/git_info.sh'
alias snvim='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh'
alias snvimp='bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
alias snvima='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh && bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
alias set-code-env='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh && bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
EOF



# Find the git_purge.sh script dynamically
PURGE_SCRIPT=$(find "$HOME/$FOLDER_NAME/" -type f -name "git_purge.sh" | head -n 1)

# Check if the script exists before proceeding
if [ -z "$PURGE_SCRIPT" ]; then
    echo "❌ ERROR: git_purge.sh script not found!"
    exit 1
fi

# Ensure the purge script is executable
echo "🔧 Granting execution permissions to $PURGE_SCRIPT..."
chmod +x "$PURGE_SCRIPT"

# Add git-purge alias
echo "🔗 Adding git-purge alias to $SHELL_CONFIG..."
echo "alias git-purge='bash $PURGE_SCRIPT'" >> "$SHELL_CONFIG"

# Apply changes immediately
echo "🔄 Applying changes to the shell configuration..."
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
else
    echo "❌ ERROR: No compatible shell configuration file found!"
    exit 1
fi


echo "✅ All set! The aliases have been added and the scripts are executable."
echo "          "
echo " ██████╗ ██╗████████╗     ███████╗███╗   ██╗██╗   ██╗       ██╗   ██╗████████╗██╗██╗     ███████╗"
echo "██╔════╝ ██║╚══██╔══╝     ██╔════╝████╗  ██║██║   ██║       ██║   ██║╚══██╔══╝██║██║     ██╔════╝"
echo "██║  ███╗██║   ██║        █████╗  ██╔██╗ ██║██║   ██║       ██║   ██║   ██║   ██║██║     ███████╗"
echo "██║   ██║██║   ██║        ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝       ██║   ██║   ██║   ██║██║     ╚════██║"
echo "╚██████╔╝██║   ██║███████╗███████╗██║ ╚████║ ╚████╔╝███████╗╚██████╔╝   ██║   ██║███████╗███████║"
echo " ╚═════╝ ╚═╝   ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝"
echo "                created by Ismaelucky342 - 2025/03/21 - ismherna@student.42madrid.com - 42 Madrid"                                                                             
echo "          "
echo "🚀 Happy coding! 🚀"
echo "⚠️ If you have troubles with the commands, run source ~/.bashrc or source ~/.zshrc"
