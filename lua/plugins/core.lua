return {
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
	{
		"rmagatti/auto-session",
		config = true,
	},
	{
		"numtostr/BufOnly.nvim",
		config = function()
			vim.keymap.set("n", "<A-q>a", ":BufOnly<cr>", {})
		end,
	},
}
