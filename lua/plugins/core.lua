return {
  -- VIM: THEME
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				transparent_background = true,
				default_integrations = true,
				integrations = {
					cmp = true,
					nvimtree = true,
					treesitter = true,
					gitsigns = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
  -- VIM: AUTO SESSION
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
  -- VIM: BUF ONLY
	{
		"numtostr/BufOnly.nvim",
		config = function()
			vim.keymap.set("n", "<A-q>a", ":BufOnly<cr>", {})
		end,
	},
}
