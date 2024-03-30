return {
	--TELESCOPE
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-file-browser.nvim",
			"jonarrien/telescope-cmdline.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{
				"nvim-tree/nvim-web-devicons",
				enabled = vim.g.have_nerd_font,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					path_display = { "smart" },
					layout_config = {
						horizontal = {
							prompt_position = "top",
							width = 0.6,
							height = 0.4,
						},
					},
					mappings = {
						i = {
							["<c-p>"] = require("telescope.actions.layout").toggle_preview,
							["<c-k>"] = require("telescope.actions").move_selection_previous,
							["<c-j>"] = require("telescope.actions").move_selection_next,
							["<a-j>"] = require("telescope.actions").preview_scrolling_down,
							["<a-k>"] = require("telescope.actions").preview_scrolling_up,
						},
						n = {
							["<c-p>"] = require("telescope.actions.layout").toggle_preview,
							["<a-j>"] = require("telescope.actions").preview_scrolling_down,
							["<a-k>"] = require("telescope.actions").preview_scrolling_up,
							["<space>"] = require("telescope.actions").select_default,
						},
					},
					preview = {
						hide_on_startup = true,
					},
				},
				extensions = {
					file_browser = {
						initial_mode = "normal",
						defaults = {},
						mappings = {
							n = {
								["<c-b>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
								["<c-r>"] = require("telescope._extensions.file_browser.actions").goto_cwd,
								["<c-v>a"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
								["<c-f>"] = require("telescope._extensions.file_browser.actions").toggle_browser,
								["<c-t>"] = require("telescope._extensions.file_browser.actions").toggle_all,
								["<c-o>"] = require("telescope._extensions.file_browser.actions").open,
							},
						},
					},
					cmdline = {
						picker = {
							layout_config = {
								height = 12,
							},
						},
					},
				},
			})

			pcall(require("telescope").load_extension, "file_browser")
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension("cmdline"))

			local file_browser_cmd = ":Telescope file_browser path=%:p:h select_buffer=true<cr>"
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ff", builtin.buffers, { desc = "[F]ind existing buffers" })
			vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<tab>", file_browser_cmd, { desc = "[F]ile Browser Folder" })
			vim.keymap.set("n", ":", "<cmd>Telescope cmdline<cr>", { desc = "[C]md [L]ine" })
		end,
	},
	--TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"vimdoc",
					"angular",
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"lua",
					"c_sharp",
					"rust",
					"sql",
					"json",
					"http",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	--LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("group-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					local builtin = require("telescope.builtin")
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")
					map("K", vim.lsp.buf.hover, "[H]over [D]ocumentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				tsserver = {},
				angularls = {
					cmd = { "ngserver", "--stdio", "--tsProbeLocations", "node_modules/@angular/language-server" },
					filetypes = {
						"html",
						"javascript",
						"typescript",
					},
				},
				cssls = {
					filetypes = {
						"css",
						"html",
						"less",
						"scss",
					},
				},
				emmet_ls = {
					filetypes = {
						"css",
						"html",
						"javascript",
						"typescript",
						"less",
						"scss",
						"typescriptreact",
					},
				},
				tailwindcss = {},
				omnisharp = {},
				sqlls = {},
				html = {
					filetypes = {
						"css",
						"html",
						"javascript",
						"typescript",
						"less",
						"scss",
						"typescriptreact",
					},
				},
			}

			require("mason").setup({})

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"prettierd",
				"sql-formatter",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	--CMP
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<a-j>"] = cmp.mapping.scroll_docs(4),
					["<a-k>"] = cmp.mapping.scroll_docs(-4),
					["<C-leader>"] = cmp.mapping.complete(),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
					["<tab>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					["<c-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
								""
							)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<c-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
								""
							)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "completion-nvim" },
				},
			})
		end,
	},
}
