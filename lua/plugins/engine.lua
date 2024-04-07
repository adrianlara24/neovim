--TODO: make finde files set insert mode by default in telescope

return {
	--VIM: TELESCOPE
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-file-browser.nvim",
			"jonarrien/telescope-cmdline.nvim",
			"folke/todo-comments.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					initial_mode = "normal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
					},
					preview = {
						hide_on_startup = true,
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
				},
				extensions = {
					file_browser = {
						mappings = {
							n = {
								["<c-b>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
								["<c-r>"] = require("telescope._extensions.file_browser.actions").goto_cwd,
								["<c-h>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
								["<c-f>"] = require("telescope._extensions.file_browser.actions").toggle_browser,
							},
						},
					},
					cmdline = {
						picker = {
							initial_mode = "insert",
							layout_config = {
								height = 12,
							},
						},
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "file_browser")
			pcall(require("telescope").load_extension, "cmdline")

			local keymap = vim.keymap
			local file_browser = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>"
			keymap.set("n", "<leader>fh", "<cmd>Telescope search_help<CR>", { desc = "Find help" })
			keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })
			keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
			keymap.set("n", "<leader>ff", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
			keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find Grep" })
			keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics" })
			keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
			keymap.set("n", "<tab>", file_browser, { desc = "File browser" })
			keymap.set("n", ":", "<cmd>Telescope cmdline<CR>", { desc = "Command line" })
		end,
	},
	--VIM: TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
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
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
	--VIM: CMP
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			{ "L3MON4D3/LuaSnip", version = "*" },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<A-k>"] = cmp.mapping.scroll_docs(-4),
					["<A-j>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),

				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})
		end,
	},
	--VIM: MASON
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_lspconfig.setup({
				ensure_installed = {
					"angularls",
					"tsserver",
					"html",
					"cssls",
					"tailwindcss",
					"lua_ls",
					"emmet_ls",
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"eslint_d",
				},
			})
		end,
	},
	--VIM: LSP
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local keymap = vim.keymap

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					-- set keybinds
					opts.desc = "Show LSP references"
					keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

					opts.desc = "Go to declaration"
					keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

					opts.desc = "Show LSP definitions"
					keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

					opts.desc = "Show LSP implementations"
					keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

					opts.desc = "Show LSP type definitions"
					keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

					opts.desc = "Show buffer diagnostics"
					keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

					opts.desc = "Show line diagnostics"
					keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

					opts.desc = "Go to previous diagnostic"
					keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

					opts.desc = "Go to next diagnostic"
					keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
				end,
			})

			local capabilities = cmp_nvim_lsp.default_capabilities()
			mason_lspconfig.setup_handlers({
				-- default handler for installed servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- configure lua server (with special settings)
				["emmet_ls"] = function()
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescript",
							"javascript",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
						},
					})
				end,
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
			})
		end,
	},
}
