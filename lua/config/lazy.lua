-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    -- Syntax and treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
          dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make", -- Requires `make` installed on your system
    },
    -- LSP and completion
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },

    -- Additional plugins
    { "vim-airline/vim-airline" },                      -- Status line
    { "tpope/vim-fugitive", cmd = { "Git", "Gdiffsplit" } }, -- Git commands
    { "tpope/vim-sleuth" }, --Fixes indentation
    { "lervag/vimtex", ft = { "tex", "latex" } },       -- LaTeX support
    { "lewis6991/gitsigns.nvim" },
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})