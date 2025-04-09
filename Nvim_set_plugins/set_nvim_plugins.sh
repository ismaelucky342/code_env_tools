#!/bin/bash

echo "🚀 Installing custom Neovim configuration..."
# Directories
NVIM_CONFIG="$HOME/.config/nvim"
NVIM_DATA="$HOME/.local/share/nvim"

# Create structure
mkdir -p "$NVIM_CONFIG"
mkdir -p "$NVIM_DATA/lazy"

# Install Lazy.nvim
if [ ! -d "$NVIM_DATA/lazy/lazy.nvim" ]; then
    echo "📥 Cloning Lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$NVIM_DATA/lazy/lazy.nvim"
fi

# Create init.lua file
cat > "$NVIM_CONFIG/init.lua" << 'EOF'
-- Load Lazy.nvim
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- Plugins
require("lazy").setup({
    -- 🎨 Tokyonight theme
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
        vim.cmd("colorscheme tokyonight")
    end },

    -- 📌 Plugin manager
    { "folke/lazy.nvim" },

    -- 🚀 LSP + Mason (Installer)
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason-lspconfig.nvim" },

    -- 🤖 Autocompletion
    { "hrsh7th/nvim-cmp", dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    }},
    
    -- GitHub Copilot
    { "github/copilot.vim" },

    -- 🔎 Navigation
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    -- 📁 File tree
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
        -- Configuración de NvimTree
            require("nvim-tree").setup({
                -- Configuración opcional
                view = {
                    width = 30,  -- Ajustar el ancho del árbol
                    side = "left",  -- Ubicación del árbol (izquierda/derecha)
                    number = false,  -- No mostrar números de línea en el árbol
                    relativenumber = false,  -- No mostrar números relativos en el árbol
                },
                filters = {
                    dotfiles = true,  -- Mostrar archivos ocultos
                },
                renderer = {
                    icons = {
                        show = {
                            git = true,  -- Mostrar íconos de git
                            folder = true,  -- Mostrar íconos de carpetas
                            file = true,  -- Mostrar íconos de archivos
                        },
                    },
                },
            })
        vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })  -- Shortcut to open/close
    end },

    -- 🧭 Status line
    { "nvim-lualine/lualine.nvim", config = function()
        require("lualine").setup()
    end },
})

-- Configure LSP per language
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.jdtls.setup({})
lspconfig.pyright.setup({})

-- Basic autocompletion configuration
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

-- Useful keybindings
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- General configuration
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
EOF

echo "✅ Done! Open Neovim and run ':Lazy sync'"
