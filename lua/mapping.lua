
-- Leader key
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
-- Key mappinrequire('gitsigns')
local map = vim.api.nvim_set_keymap
--map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>pv", ":Ex<CR>", opts)
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)
map("n", ";", ":", opts)

-- Telescope plugin keybinds
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find Files" })
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tarequire('gitsigns')<cr>", { desc = "Find Help" })

-- Gitsigns plugin keybinds
vim.keymap.set('n', ']c', function() 
  require('gitsigns').next_hunk()
end, {desc="Next Git Hunk"})

vim.keymap.set('n', '[c', function() 
  require('gitsigns').prev_hunk() 
end, {desc="Previous Git Hunk"})

vim.keymap.set('n', '<leader>hs', function() 
  require('gitsigns').stage_hunk() 
end, {desc="Stage Git Hunk"})

vim.keymap.set('n', '<leader>hr', function()
  require('gitsigns').reset_hunk()
end, {desc="Reset Git Hunk"})

vim.keymap.set('n', '<leader>hS', function() 
  require('gitsigns').stage_buffer() 
end, {desc="Stage entire buffer"})

vim.keymap.set('n', '<leader>hu', function() 
  require('gitsigns').undo_stage_hunk() 
end, {desc="Undo Stage Hunk"})

vim.keymap.set('n', '<leader>hp', function() 
  require('gitsigns').preview_hunk() 
end, {desc="Preview Git Hunk"})

vim.keymap.set('n', '<leader>hb', function() 
  require('gitsigns').blame_line() 
end, {desc='Blame line'})

vim.keymap.set('n', '<leader>hd', function() 
  require('gitsigns').diffthis() 
end, {desc='Show diff'})
