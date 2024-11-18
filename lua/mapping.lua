
-- Leader key
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
-- Key mappings
local map = vim.api.nvim_set_keymap
--map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>pv", ":Ex<CR>", opts)
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)
map("n", ";", ":", opts)

-- Telescope plugins
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find Files" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })

