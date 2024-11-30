-- Leader key
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
-- Key mappinrequire('gitsigns')
local map = vim.api.nvim_set_keymap
local mapp = vim.keymap.set
-- Insert Keybinds
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)

-- Normal Keybinds
map("n", "<leader>pv", ":Ex<CR>", opts)
map("n", ";", ":", opts)
map("n", "<C-n>", ":noh<CR>", opts)
map("n", "<C-d>", "<C-d>zz", opts) -- go down half a page and center
map("n", "<C-u>", "<C-u>zz", opts) -- go up half a page and center
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<leader>Y", [["+Y]], opts)           -- yank the current line to the system keyboard
mapp({ "n", "v" }, "<leader>y", [["+y]], opts) -- Yank to the system clipboard
mapp({ "n", "v" }, "<leader>d", [["_d]], opts) -- delete text without affecting the yank (unnamed) register
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Visual Keybinds
map("v", "J", ":m '>+1<CR>gv=gv", opts) -- move line down 1
map("v", "K", ":m '<-2<CR>gv=gv", opts) -- move line up 1
map("x", "<leader>p", [["_dP]], opts)   -- Replaces text without replacing the yank register (so you can yank and replace multiple things)

-- Telescope plugin keybinds
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find Files" })
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tarequire('gitsigns')<cr>", { desc = "Find Help" })
map("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find Help" })
mapp("n", "<leader>fw", function()
  local word = vim.fn.expand("<cword>")
  require('telescope.builtin').grep_string({ search = word })
end, { desc = "grep current word" })
mapp("n", "<leader>fW", function()
  local word = vim.fn.expand("<cWORD>")
  require('telescope.builtin').grep_string({ search = word })
end, { desc = "grep current WORD" })

map('n', '<leader>vf', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true, desc = "SV format" })

-- Gitsigns plugin keybinds
mapp('n', ']c', function()
  require('gitsigns').next_hunk()
end, { desc = "Next Git Hunk" })

mapp('n', '[c', function()
  require('gitsigns').prev_hunk()
end, { desc = "Previous Git Hunk" })

mapp('n', '<leader>hs', function()
  require('gitsigns').stage_hunk()
end, { desc = "Stage Git Hunk" })

mapp('n', '<leader>hr', function()
  require('gitsigns').reset_hunk()
end, { desc = "Reset Git Hunk" })

mapp('n', '<leader>hS', function()
  require('gitsigns').stage_buffer()
end, { desc = "Stage entire buffer" })

mapp('n', '<leader>hu', function()
  require('gitsigns').undo_stage_hunk()
end, { desc = "Undo Stage Hunk" })

mapp('n', '<leader>hp', function()
  require('gitsigns').preview_hunk()
end, { desc = "Preview Git Hunk" })

mapp('n', '<leader>hb', function()
  require('gitsigns').blame_line()
end, { desc = 'Blame line' })

mapp('n', '<leader>hd', function()
  require('gitsigns').diffthis()
end, { desc = 'Show diff' })

local ls = require("luasnip")
mapp({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true, desc = "luasnip expand" })
mapp({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true, desc = "luasnip jump +1" })
mapp({ "i", "s" }, "<C-s>;", function() ls.jump(-1) end, { silent = true, desc = "luasnip jump -1" })

mapp({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })


