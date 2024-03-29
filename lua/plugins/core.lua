return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				integrations = {
					cmp = true,
					nvimtree = true,
					treesitter = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"rmagatti/auto-session",
		config = true,
	},
	{
		"numtostr/BufOnly.nvim",
		config = function()
			vim.keymap.set("n", "<A-c>a", ":BufOnly<cr>", {})
		end,
	},
}
