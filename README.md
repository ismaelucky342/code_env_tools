# Code Environment Tools

This repository is a collection of Bash scripts and utilities designed to simplify and enhance your Git workflow. This repository contains scripts for common Git tasks like pulling, pushing, managing branches, and displaying commit trees. It also includes helpful tools for configuring and managing your Git environment with ease.

## Features

- **Git Fix All**: Fix common issues with merging, pulling, and rebasing in a Git repository.
- **Git Pull All**: Pull the latest changes from all branches.
- **Git Push All**: Push your changes to all remote branches.
- **Git Tree**: Visualize your Git repository’s commit history in an ASCII-style tree.
- **Git Info**: Shows available Git utils aliases and their descriptions.
- **Git Purge**: Uninstalls all Git utils and removes associated aliases.
- **Git Clone All**: Clones all public repositories from a specified GitHub user.
- **Git Clean All**: Deletes all cloned git repositories in all folders and subfolders.
- **Set Nvim Raw**: Installs Neovim without plugins.
- **Set Nvim Plugins**: Installs Neovim plugins and advanced configuration.
- **Set Nvim All**: Installs Neovim and plugins.
- **Set Code Environment**: Installs Neovim, plugins, and pulls from all repositories.

## Installation

To install the Git environment tools and set up the necessary aliases, run the following command in your terminal:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ismaelucky342/git_env_tools/main/install_git_utils.sh)"
```

This command will:

1. Download the installation script.
2. Give the script execute permissions.
3. Run the installation process that configures your Git environment tools and aliases.

### Manual Installation

If you prefer to install manually, follow these steps:

1. Clone the repository to your local machine:
    
    ```bash
    git clone https://github.com/ismaelucky342/git_env_tools.git
    cd git_env_tools
    ```
    
2. Make the scripts executable:
    
    ```bash
    chmod +x Git_fix_all/*.sh Git_pull_all/*.sh Git_push_all/*.sh Git_tree/*.sh Git_info/*.sh Git_clone_all/*.sh Git_delete_repos/*.sh
    ```
    
3. Add the following aliases to your `~/.bashrc` or `~/.zshrc` file:
    
    ```bash
    alias gfix='bash $HOME/$FOLDER_NAME/Git_fix_all/pull_merge_rebase_fix.sh'
    alias gpurge='bash $HOME/$FOLDER_NAME/git_purge.sh'
    alias gpull='bash $HOME/$FOLDER_NAME/Git_pull_all/pull_all.sh'
    alias gclone='bash $HOME/$FOLDER_NAME/Git_clone_all/git_clone_all.sh'
    alias gpush='bash $HOME/$FOLDER_NAME/Git_push_all/push_all.sh'
    alias gclean='bash $HOME/$FOLDER_NAME/Git_delete_repos/git_delete_repos.sh'
    alias gtree='bash $HOME/$FOLDER_NAME/Git_tree/git_tree.sh'
    alias ginfo='bash $HOME/$FOLDER_NAME/Git_info/git_info.sh'
    alias snvim='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh'
    alias snvimp='bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
    alias snvima='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh && bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
    alias senv='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh && bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
    ```
    
    Replace `~/path_to_git_env_tools/` with the actual path to your cloned repository.
    
4. Reload your shell configuration:
    
    ```bash
    source ~/.bashrc   # or `source ~/.zshrc` if you're using Zsh
    ```
    

## Usage

Once the installation is complete, you can start using the following commands:

- **Git Purge**: Run `gpurge` to delete the git env tools repo, aliases and configs. 
- **Git Fix All**: Run `gfix` to automatically fix common issues related to Git merges, pulls, and rebases.
- **Git Pull All**: Run `gpull` to pull the latest changes from all branches in your Git repository.
- **Git Push All**: Run `gpush` to push your changes to all remote branches.
- **Git Tree**: Run `gtree` to display your repository’s commit history in a visual ASCII tree format.
- **Git Info**: Run `ginfo` to display available Git utils aliases and their descriptions.
- **Git Purge**: Run `gpurge` to uninstall all Git utils and remove the aliases from your shell configuration.
- **Git Clone All**: Run `gclone <user>` to clone all public repositories from a specified GitHub user.
- **Git Clean All**: Run `gclean` to delete all cloned git repositories in all folders and subfolders.
- **Set Nvim Raw**: Run `snvim` to install Neovim without plugins.
- **Set Nvim Plugins**: Run `snvimp` to install Neovim plugins and advanced configuration.
- **Set Nvim All**: Run `snvima` to install Neovim and plugins.
- **Set Code Environment**: Run `senv` to install Neovim, plugins, and pull from all repositories.

### Example Usage

```bash
gfix                    # Fixes common issues in your repo
gpull                   # Pulls the latest changes from all branches
gpush                   # Pushes your changes to all remote branches
gtree                   # Displays the commit history in a tree format
ginfo                   # Shows available Git utils aliases and descriptions
gpurge                  # Uninstalls all Git utils and removes aliases
gclone <user>           # Clones all public repositories from a specified GitHub user
gclean                  # Deletes all cloned git repositories in all folders and subfolders
snvim                   # Installs Neovim without plugins
snvimp                  # Installs Neovim plugins and advanced configuration
snvima                  # Installs Neovim and plugins
senv                    # Installs Neovim, plugins, and pulls from all repositories
```
