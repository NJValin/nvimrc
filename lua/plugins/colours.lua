function Colourize(colour)
	colour = colour or "melange"
	vim.cmd.colorscheme(colour)
end

return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {"melange",
					"tokyonight",
					"rose-pine",
					"kanagawa-lotus",
					"kanagawa-dragon",
					"kanagawa-wave",
					{
						name = "Oxocarbon Light",
						colorscheme = "oxocarbon",
						before = [[
							vim.opt.background = "light"
						]],
					},
					{
						name = "Oxocarbon Dark",
						colorscheme = "oxocarbon",
						before = [[
							vim.opt.background = "dark"
						]],
					},},
				livePreview = true, -- Apply theme while picking. Default to true
				
			})
		end
	},
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
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		config = function ()
			vim.cmd("colorscheme kanagawa")
		end
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		config = function ()
			vim.cmd("colorscheme oxocarbon")
		end
		-- Add in any other configuration; 
		--   event = foo, 
		--   config = bar
		--   end,
	},
}
