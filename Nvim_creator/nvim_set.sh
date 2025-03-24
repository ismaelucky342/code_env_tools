#!/bin/bash

set -e  

NVIM_DIR="$HOME/.local/nvim"
CONFIG_DIR="$HOME/.config/nvim"
PLUGINS_DIR="$HOME/.local/share/nvim/site/autoload"
BIN_DIR="$HOME/.local/bin"

if [ ! -d "$NVIM_DIR" ]; then
    echo "Descargando Neovim..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    tar xzf nvim-linux64.tar.gz
    mv nvim-linux64 "$NVIM_DIR"
    rm nvim-linux64.tar.gz
fi

if ! command -v nvim &> /dev/null; then
    echo "export PATH=\"$NVIM_DIR/bin:\$PATH\"" >> "$HOME/.bashrc"
    echo "export PATH=\"$NVIM_DIR/bin:\$PATH\"" >> "$HOME/.zshrc"
    export PATH="$NVIM_DIR/bin:$PATH"
fi

if [ ! -f "$PLUGINS_DIR/plug.vim" ]; then
    echo "Instalando vim-plug..."
    curl -fLo "$PLUGINS_DIR/plug.vim" --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

mkdir -p "$CONFIG_DIR"

cat > "$CONFIG_DIR/init.vim" <<EOF
" Configuración básica para programar en C

" Establecer número de línea
set number
set relativenumber

" Indentación automática
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Resaltado de sintaxis
syntax on
filetype plugin indent on

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
call plug#end()

" Configurar clangd para autocompletado en C
let g:coc_global_extensions = ['coc-clangd']

" Mapeos útiles
nnoremap <C-n> :NERDTreeToggle<CR>
EOF

# Instalar los plugins de Neovim
echo "Instalando plugins de Neovim..."
nvim +PlugInstall +qall

echo "✅ Neovim instalado y configurado para C en $NVIM_DIR"
