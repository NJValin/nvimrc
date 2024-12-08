return {
	{

		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		config = function()
			local cmp = require('cmp')
			local cmp_lsp = require("cmp_nvim_lsp")
			local lspconfig = require("lspconfig")
			local util = require('lspconfig.util')
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()))

			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
				--vim.lsp.buf_attach_client(bufnr, client)
				--print(vim.lsp.buf_is_attached(bufnr, client))

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
				vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
				vim.keymap.set('n', '<C-S-k>', vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set('n', '<leader>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
				vim.keymap.set('n', '<leader>va', vim.lsp.buf.code_action, bufopts)
				vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references,
					bufopts)
				vim.keymap.set('n', '<leader>vf', vim.lsp.buf.format,
					bufopts)
			end

			require("fidget").setup({})
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"svls",
					"clangd",
					"jdtls",
					"pyright",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup {
							capabilities = capabilities
						}
					end,

					["lua_ls"] = function()
						lspconfig.lua_ls.setup {
							on_attach = on_attach,
							capabilities = capabilities,
							on_init = function(client)
								if client.workspace_folders then
									local path = client.workspace_folders[1].name
									if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
										return
									end
								end
								client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
									runtime = {
										-- Tell the language server which version of Lua you're using
										-- (most likely LuaJIT in the case of Neovim)
										version = 'LuaJIT'
									},
									-- Make the server aware of Neovim runtime files
									workspace = {
										checkThirdParty = false,
										library = {
											vim.env.VIMRUNTIME
											-- Depending on the usage, you might want to add additional paths here.
											-- "${3rd}/luv/library"
											-- "${3rd}/busted/library",
										}
										-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
										-- library = vim.api.nvim_get_runtime_file("", true)
									}
								})
							end,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim", "it", "describe", "before_each", "after_each" },
									}
								}
							}
						}
					end,
					["svls"] = function()
						lspconfig.svls.setup {
							cmd = { "svls" },                  -- Ensure `svls` is in your PATH
							on_attach = on_attach,             -- Reuse your shared on_attach
							capabilities = capabilities,       -- Reuse shared capabilities
							root_dir = require("lspconfig.util").find_git_ancestor, -- Detect project root
							settings = {
								svls = {
									systemverilog = {
										includeIndexing = true, -- Index `include` files
										excludePaths = {}, -- Add any paths to exclude from indexing
										format = {
											enable = true, -- Enable formatting
											tabSize = 4, -- Set the preferred tab size
										},
										defines = {}, -- Optional: Preprocessor macros
										require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" }),
										includePaths = {
											"/mnt/c/Computing/UVM/1800.2-2020.3.1/src/**", -- Add include paths
										},
										lint = {
											enabled = true, -- Enable linting
										},
									},
								},
							},
						}
					end,
					--[[["verible"] = function()
						require("lspconfig").verible.setup {
							on_attach = on_attach,              -- Use your shared on_attach function
							capabilities = capabilities,        -- Shared capabilities (e.g., for nvim-cmp)
							cmd = { "/usr/bin/verible-verilog-ls", "--background", "--log=info", "--indentation_spaces 4"}, -- Path to the verible-ls binary
							root_dir = require("lspconfig.util").find_git_ancestor, -- Standard root detection
							settings = {
								verible = {
									diagnostics = {
										lint = true, -- Enable linting support
									},
								},
							},
						}
					end,--]]
					["pyright"] = function()
						lspconfig.pyright.setup {}
					end,
					["clangd"] = function()
						lspconfig.clangd.setup {
							on_attach = on_attach,               -- Use the shared on_attach function
							capabilities = capabilities,         -- Shared capabilities for all servers
							cmd = { "clangd", "--background-index", "--clang-tidy" }, -- Optional flags for clangd
							root_dir = util.find_git_ancestor,   -- Root directory detection
							settings = {
								clangd = {
									fallbackFlags = { "-std=c++17" }, -- Optional fallback flags
								},
							},
						}
					end,
					["jdtls"] = function()
						local home = vim.env.HOME
						local workspace_dir = home ..
							"/.local/share/nvim/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

						lspconfig.jdtls.setup {
							cmd = {
								"/usr/java/bin", -- Path to your Java executable
								"-Declipse.application=org.eclipse.jdt.ls.core.id1",
								"-Dosgi.bundles.defaultStartLevel=4",
								"-Declipse.product=org.eclipse.jdt.ls.core.product",
								"-Dlog.level=ALL",
								"-Xms1g",
								"--add-modules=ALL-SYSTEM",
								"--add-opens", "java.base/java.util=ALL-UNNAMED",
								"--add-opens", "java.base/java.lang=ALL-UNNAMED",
								"-jar", home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
								"-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_linux", -- Adjust for your OS
								"-data", workspace_dir,
							},
							on_attach = on_attach,
							capabilities = capabilities,
							root_dir = require("lspconfig.util").find_git_ancestor(vim.fn.getcwd()),
							settings = {
								java = {
									eclipse = { downloadSources = true },
									configuration = {
										updateBuildConfiguration = "interactive",
									},
									maven = { downloadSources = true },
									implementationsCodeLens = { enabled = true },
									referencesCodeLens = { enabled = true },
									references = {
										includeDecompiledSources = true,
									},
									format = { enabled = true },
								},
							},
							init_options = {
								bundles = {}, -- Add paths to debug bundles if needed
							},
						}
					end,
					["rust_analyzer"] = function()
						require("lspconfig").rust_analyzer.setup {
							on_attach = on_attach, -- Your shared on_attach function
							capabilities = capabilities, -- Shared capabilities for nvim-cmp
							settings = {
								["rust-analyzer"] = {
									assist = {
										importGranularity = "module",
										importPrefix = "by_self",
									},
									cargo = {
										loadOutDirsFromCheck = true,
									},
									procMacro = {
										enable = true,
									},
									checkOnSave = {
										command = "clippy",
									},
								},
							},
						}
					end,
				}
			})

			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local ls = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body) -- For `luasnip` users.
					end,

				},
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<C-y>"] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					},
					["<C-space>"] = cmp.mapping.complete(),
				}),

				-- The order of sources matter. That gives them priority
				-- You can configure:
				--	keyword_length
				--	priority
				--	max_item_count
				sources = cmp.config.sources({
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "gh_issues" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				})
			})

			vim.diagnostic.config({
				-- update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})
		end
	},

	{
		"simrat39/rust-tools.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local rt = require("rust-tools")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities())

			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
				--vim.lsp.buf_attach_client(bufnr, client)
				--print(vim.lsp.buf_is_attached(bufnr, client))

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
				-- Code action groups
				vim.keymap.set("n", "<Leader>va", rt.code_action_group.code_action_group, { buffer = bufnr })
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
				vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
				vim.keymap.set('n', '<C-S-k>', vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set('n', '<leader>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
				vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references,
					bufopts)
				vim.keymap.set('n', '<leader>vf', vim.lsp.buf.format,
					bufopts)
			end
			require("rust-tools").setup {
				server = {
					on_attach = on_attach, -- Reuse shared on_attach
					capabilities = capabilities, -- Reuse shared capabilities
					settings = {
						["rust-analyzer"] = {
							cargo = {
								loadOutDirsFromCheck = true,
							},
							procMacro = {
								enable = true,
							},
							checkOnSave = {
								command = "clippy",
							},
						},
					},
					dap = {
						adapter = require("rust-tools.dap").get_codelldb_adapter(
							"/path/to/codelldb", -- Path to codelldb executable
							"/path/to/liblldb.so" -- Adjust for your OS (liblldb.dylib for macOS)
						),
					},
				},
			}
		end,
	},
}
