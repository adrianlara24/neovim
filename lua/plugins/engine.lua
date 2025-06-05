return {
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
					"json",
					"yaml",
					"markdown",
					"http",
					"java",
					"xml",
				},
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true },
			})
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"ts_ls",
				"angularls",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"emmet_ls",
				"jsonls",
				"yamlls",
				"jdtls",
				"lemminx",
			},
			automatic_enable = true,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"prettier",
				"eslint_d",
				"xmlformatter",
				"google-java-format",
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "williamboman/mason-lspconfig.nvim" },
		version = "1.*",
		opts = {
			keymap = {
				["<C-space>"] = { "show", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-l>"] = { "accept", "fallback" },
				["<C-h>"] = { "cancel", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()

			vim.lsp.config["emmet_ls"] = {
				cmd = { "emmet-ls", "--stdio" },
				filetypes = {
					"html",
					"vue",
					"javascript",
					"typescript",
					"svelte",
				},
			}

			vim.lsp.config["angularls"] = {
				cmd = { "angularls", "--stdio" },
				filetypes = {
					"html",
					"javascript",
					"typescript",
				},
			}

			vim.lsp.config["html"] = {
				cmd = { "html-languageserver", "--stdio" },
				filetypes = {
					"html",
					"javascript",
					"typescript",
					"svelte",
				},
			}

			vim.lsp.config["cssls"] = {
				cmd = { "css-languageserver", "--stdio" },
				filetypes = {
					"html",
					"css",
					"scss",
					"less",
					"vue",
					"javascript",
					"typescript",
					"svelte",
				},
			}

			vim.lsp.config["lua_ls"] = {
				cmd = { "lua-language-server", "--stdio" },
				filetypes = { "lua" },
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome", "prettierd", "prettier", "eslint_d", stop_after_first = true },
				typescript = { "biome", "prettierd", "prettier", "eslint_d", stop_after_first = true },
				css = { "biome", "prettierd", "prettier", stop_after_first = true },
				scss = { "biome", "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				xml = { "xmlformatter" },
				java = { "google-java-format" },
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
			float = { max_width = 0.4, max_height = 0.4 },
			view_options = { show_hidden = true },
			keymaps = { ["q"] = "actions.close" },
		},
	},
	{ "j-hui/fidget.nvim", opts = {} },
	{ "echasnovski/mini.comment", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", version = "*", opts = {} },
	{ "echasnovski/mini.icons", version = "*", opts = {} },
	{ "echasnovski/mini.statusline", version = "*", opts = {} },
	{ "echasnovski/mini.jump2d", version = "*", opts = { mappings = { start_jumping = "<c-a>" } } },
	{ "rmagatti/auto-session", version = "*", opts = { auto_restore_enabled = false } },
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			explorer = { enabled = true },
			picker = { enabled = true, focus = "list" },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			zoom = { enabled = true },
			lazygit = { enabled = true },
			gitbrowse = { enabled = true },
			statuscolumn = { enabled = true },
			layout = { enabled = true },
			terminal = { enabled = true, shell = "pwsh.exe" },
			input = { enabled = true },
		},
	},
}
