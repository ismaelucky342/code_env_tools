# Git Environment Tools

**Git Environment Tools** is a collection of Bash scripts and utilities designed to simplify and enhance your Git workflow. This repository contains scripts for common Git tasks like pulling, pushing, managing branches, and displaying commit trees. It also includes helpful tools for configuring and managing your Git environment with ease.

## Features

- **Git Fix All**: Fix common issues with merging, pulling, and rebasing in a Git repository.
- **Git Pull All**: Pull the latest changes from all branches.
- **Git Push All**: Push your changes to all remote branches.
- **Git Tree**: Visualize your Git repository’s commit history in an ASCII-style tree.
- **Git Info**: Shows available Git utils aliases and their descriptions.
- **Git Purge**: Uninstalls all Git utils and removes associated aliases.

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
    chmod +x Git_fix_all/*.sh Git_pull_all/*.sh Git_push_all/*.sh Git_tree/*.sh Git_info/*.sh
    ```
    
3. Add the following aliases to your `~/.bashrc` or `~/.zshrc` file:
    
    ```bash
    alias git-fix-all='bash ~/path_to_git_env_tools/Git_fix_all/pull_merge_rebase_fix.sh'
    alias git-pull-all='bash ~/path_to_git_env_tools/Git_pull_all/pull_all.sh'
    alias git-push-all='bash ~/path_to_git_env_tools/Git_push_all/push_all.sh'
    alias git-tree='bash ~/path_to_git_env_tools/Git_tree/git_tree.sh'
    alias git-info='bash ~/path_to_git_env_tools/Git_info/git-info.sh'
    alias git-utils-uninstall='bash ~/path_to_git_env_tools/git-utils-uninstall.sh'
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
- **Git Utils Uninstall**: Run `git-utils-uninstall` to uninstall all Git utils and remove the aliases from your shell configuration.

### Example Usage

```bash
git-fix-all      # Fixes common issues in your repo
git-pull-all     # Pulls the latest changes from all branches
git-push-all     # Pushes your changes to all remote branches
git-tree         # Displays the commit history in a tree format
git-info         # Shows available Git utils aliases and descriptions
git-utils-uninstall # Uninstalls all Git utils and removes aliases
```
