vim.o.number = true
--vim.o.relativenumber = true
vim.o.expandtab = false
vim.opt.tabstop = 4        -- Number of spaces a tab character represents
vim.opt.shiftwidth = 4     -- Number of spaces to use for each indentation level
vim.opt.softtabstop = 4    -- Makes <Tab> behave consistently with the above settings

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99  -- High value to keep all folds open by default
vim.opt.foldenable = true  -- Keep folding enabled
vim.opt.guicursor = "n-v-c:block,i-ci:ver25,r-cr:hor20,o:hor50"

vim.opt.listchars = {  tab = '⤷  ', trail = '·', nbsp = '⎵' }

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize =25
