# Code Environment Tools

Colección de scripts Bash para automatizar tareas comunes de desarrollo, gestión de proyectos y Git. Incluye utilidades para entornos Python, Node, Docker, limpieza, backup, y gestión avanzada de repositorios Git y Neovim.

## Alias disponibles

### Workspace utils

- **pyenv**: Crea y activa entorno virtual Python, instala requirements.txt si existe.
- **nenv**: Instala dependencias npm/yarn y ejecuta build/test si hay package.json.
- **dockup**: Lanza docker-compose up si existe docker-compose.yml.
- **ports**: Muestra puertos abiertos y procesos asociados.
- **kport**: Mata el proceso que usa un puerto específico.
- **openp**: Abre el proyecto en VS Code.
- **lint**: Ejecuta linters sobre todo el workspace.
- **bigf**: Lista archivos grandes en el proyecto.
- **bkup**: Hace backup comprimido del workspace actual.

### Git utils

- **gfix**: Fixes issues with pull, merge, and rebase.
- **gsub**: Initializes and updates Git submodules.
- **gpull**: Pulls from all repositories.
- **gpush**: Pushes to all repositories.
- **gtree**: Displays the commit history as a tree.
- **ginfo**: Shows this information.
- **gpurge**: Uninstalls all Git utils and removes aliases.
- **gclone**: Clones all public repositories from a GitHub user.
- **gclean**: Deletes all cloned git repositories.
- **gsta**: Muestra el estado de todos los repositorios en subcarpetas.
- **gbrc**: Borra ramas locales ya fusionadas/remotas eliminadas.
- **gstsh**: Aplica git stash en todos los repositorios.
- **glogf**: Busca una palabra en los logs de todos los repos.
- **gstat**: Muestra estadísticas de contribución por usuario.
- **gundo**: Recupera archivos borrados recientemente.
- **gtag**: Crea un tag de release y lo sube al remoto.

### Neovim utils

- **snvim**: Instala Neovim sin plugins.
- **snvimp**: Instala plugins y configuración avanzada de Neovim.
- **snvima**: Instala Neovim y plugins.
- **senv**: Instala Neovim, plugins y hace pull de todos los repos.

## Instalación

Para instalar los scripts y configurar los alias ejecuta:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ismaelucky342/git_env_tools/main/install_git_utils.sh)"
```

Esto descargará y ejecutará el instalador, configurando todo automáticamente.

### Instalación manual
+- **gfix**: Fixes issues with pull, merge, and rebase.
+- **gsub**: Initializes and updates Git submodules.
+- **gpull**: Pulls from all repositories.
+- **gpush**: Pushes to all repositories.
+- **gtree**: Displays the commit history as a tree.
+- **ginfo**: Shows this information.
+- **gpurge**: Uninstalls all Git utils and removes aliases.
+- **gclone**: Clones all public repositories from a GitHub user.
+- **gclean**: Deletes all cloned git repositories.
+- **gsta**: Muestra el estado de todos los repositorios en subcarpetas.
+- **gcheck**: Cambia a un commit específico (por hash o número) o muestra la lista numerada de commits si no se pasa argumento.
+- **gbrc**: Borra ramas locales ya fusionadas/remotas eliminadas.
+- **gstsh**: Aplica git stash en todos los repositorios.
+- **glogf**: Busca una palabra en los logs de todos los repos.
+- **gstat**: Muestra estadísticas de contribución por usuario.
+- **gundo**: Recupera archivos borrados recientemente.
+- **gtag**: Crea un tag de release y lo sube al remoto.

1. Clona el repositorio:
    ```bash
    git clone https://github.com/ismaelucky342/git_env_tools.git
    cd git_env_tools
    ```
2. Da permisos de ejecución a los scripts:
    ```bash
    chmod +x Git_fix_all/*.sh Git_pull_all/*.sh Git_push_all/*.sh Git_tree/*.sh Git_info/*.sh Git_clone_all/*.sh Git_delete_repos/*.sh Workspace_utils/*.sh Git_utils/*.sh Nvim_set_raw/*.sh Nvim_set_plugins/*.sh
    ```
3. Añade los alias a tu `~/.bashrc` o `~/.zshrc` (ver sección de alias arriba).

## Contacto

Creado por Ismaelucky342 - ismherna@student.42madrid.com - 42 Madrid
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
