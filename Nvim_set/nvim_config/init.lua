-- Load Lazy.nvim
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- Plugins
require("lazy").setup({
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
        vim.cmd("colorscheme tokyonight")
    end },
    { "folke/lazy.nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp", dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    }},
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-lualine/lualine.nvim" },
})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
