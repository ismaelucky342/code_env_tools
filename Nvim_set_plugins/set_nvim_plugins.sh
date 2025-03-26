#!/bin/bash

# Neovim configuration directories
NVIM_CONFIG="$HOME/.config/nvim"
NVIM_DATA="$HOME/.local/share/nvim"
NVIM_BIN="$HOME/.local/bin"

echo "🚀 Installing Neovim Plugins and Advanced Configuration..."

# Create directory structure
mkdir -p "$NVIM_CONFIG" "$NVIM_DATA" "$NVIM_BIN"

if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
    echo "📥 Downloading Lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$HOME/.local/share/nvim/lazy/lazy.nvim"
fi

# Create init.lua configuration file
echo "📝 Creating configuration in $NVIM_CONFIG/init.lua..."
cat > "$NVIM_CONFIG/init.lua" << 'EOF'
-- Load Lazy.nvim
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lazy")

-- Install Plugins
require("lazy").setup({
    -- 🎨 UI & Colors
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
        vim.cmd("colorscheme tokyonight")
    end },
    
    -- 📌 Plugin Manager
    { "folke/lazy.nvim" },

    -- 🚀 LSP and Autocompletion
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" } },
    { "github/copilot.vim" },

    -- 🌍 Language Support
    { "fatih/vim-go" },  -- Golang
    { "pearofducks/ansible-vim" },  -- YAML
    { "pangloss/vim-javascript" },  -- Web Dev
    { "plasticboy/vim-markdown" },  -- Markdown
    { "lervag/vimtex" },  -- LaTeX
    { "StanAngeloff/php.vim" },  -- PHP
    { "bakpakin/fennel.vim" },  -- Fennel
    
    -- 🔎 Fuzzy Finder & File Explorer
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
        require("nvim-tree").setup({
            view = { width = 35 },
            renderer = { icons = { show = { file = true, folder = true, git = true } } },
            update_focused_file = { enable = true },
        })
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end },

    -- 🛠 Debugging & Terminal
    { "mfussenegger/nvim-dap" },
    { "akinsho/toggleterm.nvim" },

    -- 🎨 Enhanced UI
    { "nvim-lualine/lualine.nvim" },  -- Statusline
    { "romgrk/barbar.nvim" },  -- Tabline
    { "lukas-reineke/indent-blankline.nvim" },  -- Indent Guides
    { "lewis6991/gitsigns.nvim" },  -- Git Integration
    { "folke/trouble.nvim" },  -- Quickfix

    -- 📝 Notes and Sessions
    { "nvim-neorg/neorg" },
    { "Shatur/neovim-session-manager" },

    -- 💪 Workflow
    { "windwp/nvim-autopairs" },  -- Autoclosing Parentheses
    { "numToStr/Comment.nvim" },  -- Quick Comments
    { "tpope/vim-surround" },  -- Handling Parentheses and Quotes
    { "tpope/vim-fugitive" },  -- Git
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

    -- 🔄 Session Management
    { "rmagatti/auto-session" }
})

-- Basic plugin configuration
require("nvim-tree").setup()
require("lualine").setup({ options = { theme = "tokyonight" } })
require("telescope").setup()

-- Keybindings
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-t>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
EOF

echo "✅ Neovim configured with all required plugins"
echo "📝 Open Neovim and run ':Lazy sync' to install the plugins"
