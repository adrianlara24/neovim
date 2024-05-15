return {
	--VIM: THEMES
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
				default_integrations = true,
				integrations = {
					cmp = true,
					nvimtree = true,
					treesitter = true,
					gitsigns = true,
				},
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			local rose_pine = require("rose-pine")
			rose_pine.setup({
				variant = "moon",
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"savq/melange-nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"kdheepak/monochrome.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"maxmx03/fluoromachine.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local fm = require("fluoromachine")
			fm.setup({
				glow = true,
			})
		end,
	},
	--VIM: AUTO SESSION
	{
		"rmagatti/auto-session",
		config = function()
			local auto_session = require("auto-session")

			auto_session.setup({
				auto_restore_enabled = false,
				auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
				log_level = "error",
			})

			local keymap = vim.keymap

			keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
			keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
		end,
	},
	--VIM: BUF ONLY
	{
		"numtostr/BufOnly.nvim",
		config = function()
			vim.keymap.set("n", "<A-q>a", ":BufOnly<cr>", {})
		end,
	},
}
