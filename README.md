
# Code Environment Tools

Collection of Bash scripts to automate common development, project management, and Git tasks. Includes utilities for Python, Node, Docker environments, cleaning, backup, and advanced management of Git repositories and Neovim.

## Available Aliases

### Workspace Utilities

- **pyenv**: Creates and activates a Python virtual environment, installs requirements.txt if present.
- **nenv**: Installs npm/yarn dependencies and runs build/test if package.json exists.
- **dockup**: Runs docker-compose up if docker-compose.yml is present.
- **ports**: Shows open ports and associated processes.
- **kport**: Kills the process using a specific port.
- **openp**: Opens the project in VS Code.
- **lint**: Runs linters across the workspace.
- **bigf**: Lists large files in the project.
- **bkup**: Creates a compressed backup of the current workspace.

### Git Utilities

- **gfix**: Fixes issues with pull, merge, and rebase.
- **gsub**: Initializes and updates Git submodules.
- **gpull**: Pulls from all repositories.
- **gpush**: Pushes to all repositories.
- **gtree**: Displays the commit history as a tree.
- **ginfo**: Shows this information.
- **gpurge**: Uninstalls all Git utils and removes aliases.
- **gclone**: Clones all public repositories from a GitHub user.
- **gclean**: Deletes all cloned git repositories.
- **gsta**: Shows the status of all repositories in subfolders.
- **gbrc**: Deletes local branches already merged or with deleted remotes.
- **gstsh**: Applies git stash in all repositories.
- **glogf**: Searches for a word in the logs of all repos.
- **gstat**: Shows contribution statistics by user.
- **gundo**: Recovers recently deleted files.
- **gtag**: Creates a release tag and pushes it to remote.
- **gcheck**: Switches to a specific commit (by hash or number) or shows a numbered list of commits if no argument is given.

### Neovim Utilities

- **snvim**: Installs Neovim without plugins.
- **snvimp**: Installs Neovim plugins and advanced configuration.
- **snvima**: Installs Neovim and plugins.
- **senv**: Installs Neovim, plugins, and pulls from all repositories.

## Installation

To install the scripts and configure the aliases, run:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ismaelucky342/git_env_tools/main/install_git_utils.sh)"
```

This will download and run the installer, configuring everything automatically.

### Manual Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/ismaelucky342/git_env_tools.git
    cd git_env_tools
    ```
2. Give execution permissions to the scripts:
    ```bash
    chmod +x Git_fix_all/*.sh Git_pull_all/*.sh Git_push_all/*.sh Git_tree/*.sh Git_info/*.sh Git_clone_all/*.sh Git_delete_repos/*.sh Workspace_utils/*.sh Git_utils/*.sh Nvim_set_raw/*.sh Nvim_set_plugins/*.sh
    ```
3. Add the aliases to your `~/.bashrc` or `~/.zshrc` (see the alias section above). Example:
    ```bash
    alias ginfo='bash $HOME/$FOLDER_NAME/Git_info/git_info.sh'
    alias snvim='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh'
    alias snvimp='bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
    alias snvima='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh && bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
    alias senv='bash $HOME/$FOLDER_NAME/Nvim_set_raw/set_nvim_raw.sh && bash $HOME/$FOLDER_NAME/Nvim_set_plugins/set_nvim_plugins.sh'
    ```
    Replace `$FOLDER_NAME` with the actual folder name where you cloned the repository.
4. Reload your shell configuration:
    ```bash
    source ~/.bashrc   # or source ~/.zshrc if you're using Zsh
    ```

## Usage

Once the installation is complete, you can start using the following commands:

- **gpurge**: Uninstalls all Git utils and removes aliases and configs.
- **gfix**: Automatically fixes common issues related to Git merges, pulls, and rebases.
- **gpull**: Pulls the latest changes from all branches in all repositories.
- **gpush**: Pushes your changes to all remote branches in all repositories.
- **gtree**: Displays your repository’s commit history in a visual ASCII tree format.
- **ginfo**: Shows available Git utils aliases and their descriptions.
- **gclone <user>**: Clones all public repositories from a specified GitHub user.
- **gclean**: Deletes all cloned git repositories in all folders and subfolders.
- **snvim**: Installs Neovim without plugins.
- **snvimp**: Installs Neovim plugins and advanced configuration.
- **snvima**: Installs Neovim and plugins.
- **senv**: Installs Neovim, plugins, and pulls from all repositories.

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

## Contact

Created by Ismaelucky342 - ismherna@student.42madrid.com - 42 Madrid
