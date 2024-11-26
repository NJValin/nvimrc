function Colourize(colour)
	colour = colour or "melange"
	vim.cmd.colorscheme(colour)
end

return {
	{
		"folke/tokyonight.nvim",

		config = function()
			require("tokyonight").setup({
				style = 'storm', -- options storm, moon, night, day
				terminal_colors = true,
				styles = {
					comments = { italic = false},
					keywords = { bold=true, italic=true },

					sidebars = "dark",
					floats = "dark",
				},
			})
		end

	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require('rose-pine').setup({})
		end
	},

	{
		"savq/melange-nvim",
		config = function()
			vim.cmd("colorscheme melange")
			Colourize()
		end
	},
}
