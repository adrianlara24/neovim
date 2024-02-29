return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			insert_at_start = false,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local lualine = require("lualine")
			lualine.setup({
				options = {
					theme = "catppuccin",
				},
			})
		end,
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				backdrop = 0.3,
				width = 200,
			},
		},
		config = function()
			vim.keymap.set(
				{ "n", "v" },
				"<leader>z",
				":ZenMode<cr>",
				{ noremap = true, silent = true, desc = "Zen Mode" }
			)
		end,
	},
}
