return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup {
				defaults = {
					-- Default configuration for telescope goes here:
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					selection_caret = ">",
					path_display = { "truncate" }, -- Display truncated file paths
					sorting_strategy = "ascending", -- Sort results top to bottom
					-- config_key = value,
					mappings = {
						i = {
							-- map actions.which_key to <C-h> (default: <C-/>)
							-- actions.which_key shows the mappings for your picker,
							-- e.g. git_{create, delete, ...}_branch for the git_branches picker
							["<C-h>"] = "which_key",
							["jk"] = "close",
							["kj"] = "close"
						}
					}
				},
				pickers = {
					find_files = {
						hidden = true,
						theme = "dropdown",
					},
					live_grep = {
						theme = "ivy",       -- Use an ivy layout
					},
					-- Default configuration for builtin pickers goes here:
					-- picker_name = {
					--   picker_config_key = value,
					--   ...
					-- }
					-- Now the picker_config_key will be applied every time you call this
					-- builtin picker
				},
				extensions = {
					-- Your extension configuration goes here:
					-- extension_name = {
					--   extension_config_key = value,
					-- }
					-- please take a look at the readme of the extension you want to configure
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
				}
			}

			require('telescope').load_extension('fzf')
		end
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make", -- Requires `make` installed on your system
	},
}
