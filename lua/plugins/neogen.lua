return {
	"danymat/neogen",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local neogen = require("neogen")


		neogen.setup({
			snippet_engine = "luasnip",
			languages = {
				lua = {
					template = {
						annotation_convention = "ldoc" -- Use ldoc style for Lua
					}
				},
				python = {
					template = {
						annotation_convention = "numpydoc" -- Use Google style for Python
					}
				},
				javascript = {
					template = {
						annotation_convention = "jsdoc" -- Use JSDoc for JavaScript
					}
				},
				java = {
					template = {
						annotation_convention = "javadoc"
					}
				},
				go = {
					template = {
						annotation_convention = "godoc"
					}
				},
				c = {
					template = {
						annotation_convention = "doxygen"
					}
				},
				cpp = {
					template = {
						annotation_convention = "doxygen"
					}
				},
				sh = {
					template = {
						annotation_convention = "google_bash"
					}
				},
				rust = {
					template = {
						annotation_convention = "rustdoc"
					}
				}

			}
		})

		vim.keymap.set("n", "<leader>nf", function()
			neogen.generate({ type = "func" })
		end, { desc = "generate [f]unc" })

		vim.keymap.set("n", "<leader>nt", function()
			neogen.generate({ type = "type" })
		end, { desc = "generate [t]ype" })

		vim.keymap.set("n", "<leader>nc", function()
			neogen.generate({ type = "class" })
		end, { desc = "generate [c]lass" })

		vim.keymap.set("n", "<leader>ni", function()
			neogen.generate({ type = "file" })
		end, { desc = "generate f[i]le" })
	end
}
