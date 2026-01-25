local servers = require("servers")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = servers.treesitter,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },
			{ "mason-org/mason.nvim", opts = {} },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = servers.tools } },
		},
		opts = {
			ensure_installed = servers.lsp,
			automatic_enable = true,
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "neovim/nvim-lspconfig" },
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			keymap = {
				["<C-space>"] = { "show", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-l>"] = { "accept", "fallback" },
				["<C-h>"] = { "cancel", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			completion = {
				documentation = { auto_show = true },
				menu = { auto_show = true },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = servers.formatters,
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
	{ "echasnovski/mini.comment", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", version = "*", opts = {} },
	{ "echasnovski/mini.icons", version = "*", opts = {} },
	{
		"echasnovski/mini.statusline",
		version = "*",
		opts = { set_vim_settings = false },
		config = function(_, opts)
			require("mini.statusline").setup(opts)
			vim.o.laststatus = 0
			vim.o.winbar = "%{%v:lua.MiniStatusline.active()%}"
		end,
	},
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
	{ "mistweaverco/kulala.nvim", opts = { default_view = "verbose" } },
}
