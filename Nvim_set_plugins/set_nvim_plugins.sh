#!/bin/bash

echo "🚀 Instalando configuración personalizada de Neovim..."

# Directorios
NVIM_CONFIG="$HOME/.config/nvim"
NVIM_DATA="$HOME/.local/share/nvim"

# Crear estructura
mkdir -p "$NVIM_CONFIG"
mkdir -p "$NVIM_DATA/lazy"

# Instalar Lazy.nvim
if [ ! -d "$NVIM_DATA/lazy/lazy.nvim" ]; then
    echo "📥 Clonando Lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$NVIM_DATA/lazy/lazy.nvim"
fi

# Crear archivo init.lua
cat > "$NVIM_CONFIG/init.lua" << 'EOF'
-- Cargar Lazy.nvim
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- Plugins
require("lazy").setup({
    -- 🎨 Tema tokyonight
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
        vim.cmd("colorscheme tokyonight")
    end },

    -- 📌 Gestor de plugins
    { "folke/lazy.nvim" },

    -- 🚀 LSP + Mason (Instalador)
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim" },

    -- 🤖 Autocompletado
    { "hrsh7th/nvim-cmp", dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    }},
    
    -- GitHub Copilot
    { "github/copilot.vim" },

    -- 🔎 Navegación
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    -- 📁 Árbol de archivos
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
        require("nvim-tree").setup()
        vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end },

    -- 🧭 Línea de estado
    { "nvim-lualine/lualine.nvim", config = function()
        require("lualine").setup()
    end },
})

-- Configuración básica de LSP con Mason
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",     -- C/C++
        "jdtls",      -- Java
        "pyright",    -- Python
    },
})

-- Configurar LSP por lenguaje
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.jdtls.setup({})
lspconfig.pyright.setup({})

-- Configuración básica de autocompletado
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})

-- Keybindings útiles
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- Configuración general
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
EOF

echo "✅ ¡Listo! Abre Neovim y ejecuta ':Lazy sync'"
