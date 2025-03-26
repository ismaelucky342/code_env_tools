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
- **Git Delete All**: Deletes all cloned git repositories in all folders and subfolders.
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
    alias git-fix-all='bash ~/path_to_git_env_tools/Git_fix_all/pull_merge_rebase_fix.sh'
    alias git-pull-all='bash ~/path_to_git_env_tools/Git_pull_all/pull_all.sh'
    alias git-push-all='bash ~/path_to_git_env_tools/Git_push_all/push_all.sh'
    alias git-tree='bash ~/path_to_git_env_tools/Git_tree/git_tree.sh'
    alias git-info='bash ~/path_to_git_env_tools/Git_info/git-info.sh'
    alias git-purge='bash ~/path_to_git_env_tools/git-utils-uninstall.sh'
    alias git-clone-all='bash ~/path_to_git_env_tools/Git_clone_all/git_clone_all.sh'
    alias git-delete-all='bash ~/path_to_git_env_tools/Git_delete_repos/git_delete_repos.sh'
    alias set-nvim-raw='bash ~/path_to_git_env_tools/set_nvim_raw.sh'
    alias set-nvim-plugins='bash ~/path_to_git_env_tools/set_nvim_plugins.sh'
    alias set-nvim-all='bash ~/path_to_git_env_tools/set_nvim_all.sh'
    alias set-code-env='bash ~/path_to_git_env_tools/set_code_enviroment.sh'
    ```
    
    Replace `~/path_to_git_env_tools/` with the actual path to your cloned repository.
    
4. Reload your shell configuration:
    
    ```bash
    source ~/.bashrc   # or `source ~/.zshrc` if you're using Zsh
    ```
    

## Usage

Once the installation is complete, you can start using the following commands:

- **Git Fix All**: Run `git-fix-all` to automatically fix common issues related to Git merges, pulls, and rebases.
- **Git Pull All**: Run `git-pull-all` to pull the latest changes from all branches in your Git repository.
- **Git Push All**: Run `git-push-all` to push your changes to all remote branches.
- **Git Tree**: Run `git-tree` to display your repository’s commit history in a visual ASCII tree format.
- **Git Info**: Run `git-info` to display available Git utils aliases and their descriptions.
- **Git Purge**: Run `git-purge` to uninstall all Git utils and remove the aliases from your shell configuration.
- **Git Clone All**: Run `git-clone-all <user>` to clone all public repositories from a specified GitHub user.
- **Git Delete All**: Run `git-delete-all` to delete all cloned git repositories in all folders and subfolders.
- **Set Nvim Raw**: Run `set-nvim-raw` to install Neovim without plugins.
- **Set Nvim Plugins**: Run `set-nvim-plugins` to install Neovim plugins and advanced configuration.
- **Set Nvim All**: Run `set-nvim-all` to install Neovim and plugins.
- **Set Code Environment**: Run `set-code-env` to install Neovim, plugins, and pull from all repositories.

### Example Usage

```bash
git-fix-all            # Fixes common issues in your repo
git-pull-all           # Pulls the latest changes from all branches
git-push-all           # Pushes your changes to all remote branches
git-tree               # Displays the commit history in a tree format
git-info               # Shows available Git utils aliases and descriptions
git-purge              # Uninstalls all Git utils and removes aliases
git-clone-all <user>   # Clones all public repositories from a specified GitHub user
git-delete-all         # Deletes all cloned git repositories in all folders and subfolders
set-nvim-raw           # Installs Neovim without plugins
set-nvim-plugins       # Installs Neovim plugins and advanced configuration
set-nvim-all           # Installs Neovim and plugins
set-code-env    # Installs Neovim, plugins, and pulls from all repositories
```

### Mostrar los alias disponibles

```bash
echo "📌 Git Utils - Available Aliases:"
echo "                                                                         "
echo "🔹 git-fix                -> Fixes issues with pull, merge, and rebase."
echo "🔹 git-pull-all           -> Pulls from all repositories."
echo "🔹 git-push-all           -> Pushes to all repositories."
echo "🔹 git-tree               -> Displays the commit history as a tree."
echo "🔹 git-info               -> Shows this information."
echo "🔹 git-purge              -> Uninstalls all Git utils and removes aliases."
echo "🔹 git-clone-all <user>   -> Clones all public repositories from a GitHub user."
echo "🔹 git-delete-all         -> Deletes all cloned git repositories."
echo "🔹 set-nvim-raw           -> Installs Neovim without plugins."
echo "🔹 set-nvim-plugins       -> Installs Neovim plugins and advanced configuration."
echo "🔹 set-nvim-all           -> Installs Neovim and plugins."
echo "🔹 set-code-env    -> Installs Neovim, plugins, and pulls from all repositories."
echo ""
echo "ℹ️  You can run any alias by simply typing it in the terminal."
echo "🚀  Happy coding!"
echo "Contact me at ismhernaismherna@student.42madrid.com"
```
