return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- List of parsers to install
      ensure_installed = { "lua", "python", "verilog", "vhdl", "bash", "perl" },

      -- Automatically install missing parsers when entering a buffer
      auto_install = true,

      -- Enable syntax highlighting
      highlight = {
        enable = true,              -- Enable Treesitter-based syntax highlighting
        additional_vim_regex_highlighting = false, -- Disable Vim's regex-based highlighting
      },

      -- Enable indentation based on Treesitter
      indent = {
        enable = true,
      },

      -- Enable incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",   -- Start selection
          node_incremental = "grn", -- Increment to the upper node
          scope_incremental = "grc",-- Increment to the scope
          node_decremental = "grm", -- Decrement to the previous node
        },
      },

      -- Enable code folding based on Treesitter
      fold = {
        enable = true,
      },
    })
  end
}

