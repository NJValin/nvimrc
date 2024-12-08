local ls = require("luasnip")
local types = require("luasnip.util.types")
ls.config.set_config {
	-- Keep last snippet around for repeat operations
	history = true,

	-- Dynamic snippets update as you type
	updateevents = "TextChanged,TextChangedI",

	-- Enable auto snippets (vs. manual expansion)
	enable_autosnippets = true,

	-- Use fancy snippet markers
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "DiagnosticError" } }
			}
		}
	}
}

-- Load snippets from multiple sources
require("luasnip.loaders.from_lua").lazy_load({
	paths = vim.fn.stdpath("config") .. "/lua/snippets"
})
require("luasnip.loaders.from_vscode").lazy_load()
