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
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
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
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
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
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["cssls"] = function()
					lspconfig["cssls"].setup({
						capabilities = capabilities,
					})
				end,
				["angularls"] = function()
					lspconfig["angularls"].setup({
						capabilities = capabilities,
					})
				end,
				["ts_ls"] = function()
					lspconfig["ts_ls"].setup({
						capabilities = capabilities,
					})
				end,
				["lemminx"] = function()
					lspconfig["lemminx"].setup({
						capabilities = capabilities,
					})
				end,
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
									globals = { "vim", "Snacks", "MiniJump2d" },
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
