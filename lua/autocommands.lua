local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  pattern = "*",
  callback = function() vim.highlight.on_yank({ timeout = 400 }) end,
})
