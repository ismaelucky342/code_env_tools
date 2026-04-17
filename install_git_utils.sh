#!/bin/bash

# Repository URL and destination folder
REPO_URL="https://github.com/ismaelucky342/code_env_tools.git"
FOLDER_NAME="code_env_tools"


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
chmod +x Nvim_*/*.sh
cd ..

# Remove old aliases from the shell configuration
echo "🧹 Cleaning up old aliases from $SHELL_CONFIG..."
sed -i '/# Git utils aliases/,+5d' "$SHELL_CONFIG"

# Add new aliases
echo "🔗 Adding aliases to $SHELL_CONFIG..."
cat <<EOF >> "$SHELL_CONFIG"
# Workspace utils aliases
alias pyenv='bash $HOME/$FOLDER_NAME/Workspace_utils/pyenv.sh'
alias nenv='bash $HOME/$FOLDER_NAME/Workspace_utils/nenv.sh'
alias dockup='bash $HOME/$FOLDER_NAME/Workspace_utils/dockup.sh'
alias ports='bash $HOME/$FOLDER_NAME/Workspace_utils/ports.sh'
alias kport='bash $HOME/$FOLDER_NAME/Workspace_utils/kport.sh'
alias openp='bash $HOME/$FOLDER_NAME/Workspace_utils/openp.sh'
alias lint='bash $HOME/$FOLDER_NAME/Workspace_utils/lint.sh'
alias bigf='bash $HOME/$FOLDER_NAME/Workspace_utils/bigf.sh'
alias bkup='bash $HOME/$FOLDER_NAME/Workspace_utils/bkup.sh'

# Git utils aliases
# Git utils aliases
alias gfix='bash $HOME/$FOLDER_NAME/Git_fix_all/pull_merge_rebase_fix.sh'
alias gsub='bash $HOME/$FOLDER_NAME/Git_Submodules/submodules.sh'
alias gpurge='bash $HOME/$FOLDER_NAME/git_purge.sh'
alias gpull='bash $HOME/$FOLDER_NAME/Git_pull_all/pull_all.sh'
alias gclone='bash $HOME/$FOLDER_NAME/Git_clone_all/git_clone_all.sh'
alias gpush='bash $HOME/$FOLDER_NAME/Git_push_all/push_all.sh'
alias gclean='bash $HOME/$FOLDER_NAME/Git_delete_repos/git_delete_repos.sh'
alias gtree='bash $HOME/$FOLDER_NAME/Git_tree/git_tree.sh'
alias ginfo='bash $HOME/$FOLDER_NAME/Git_info/git_info.sh'
alias gcheck='bash $HOME/$FOLDER_NAME/Git_utils/gcheck.sh'
alias gsta='bash $HOME/$FOLDER_NAME/Git_utils/gsta.sh'
alias gbrc='bash $HOME/$FOLDER_NAME/Git_utils/gbrc.sh'
alias gstsh='bash $HOME/$FOLDER_NAME/Git_utils/gstsh.sh'
alias glogf='bash $HOME/$FOLDER_NAME/Git_utils/glogf.sh'
alias gstat='bash $HOME/$FOLDER_NAME/Git_utils/gstat.sh'
alias gundo='bash $HOME/$FOLDER_NAME/Git_utils/gundo.sh'
alias gtag='bash $HOME/$FOLDER_NAME/Git_utils/gtag.sh'

# Neovim utils aliases
alias snvim='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh'
alias snvimp='bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
alias snvima='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh && bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
alias senv='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh && bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'

alias gupdate='f() {
  cd "$HOME/$FOLDER_NAME" || return 1
  git fetch
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse @{u})
  BASE=$(git merge-base @ @{u})

  if [ "$LOCAL" = "$REMOTE" ]; then
    echo "Already up to date."
  elif [ "$LOCAL" = "$BASE" ]; then
    echo "Changes found on remote. Pulling..."
    git pull
  elif [ "$REMOTE" = "$BASE" ]; then
    echo "You have local commits that haven’t been pushed."
  else
    echo "Diverged. Manual intervention needed."
  fi
  cd - > /dev/null
}; f'

EOF

# Find the git_purge.sh script dynamically
PURGE_SCRIPT=$(find "$HOME/$FOLDER_NAME/" -type f -name "git_purge.sh" | head -n 1)

# Check if the script exists before proceeding
if [ -z "$PURGE_SCRIPT" ]; then
    echo "❌ ERROR: git_purge.sh script not found!"
    exit 1
fi

echo "🔧 Granting execution permissions to $PURGE_SCRIPT..."
chmod +x "$PURGE_SCRIPT"

# Add gpurge alias
echo "🔗 Adding gpurge alias to $SHELL_CONFIG..."
echo "alias gpurge='bash $PURGE_SCRIPT'" >> "$SHELL_CONFIG"

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
