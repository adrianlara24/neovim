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
		"eoh-bse/minintro.nvim",
		config = true,
		lazy = false,
		opts = {
			color = "#ffffff",
			always_show_bufferline = false,
		},
	},
}
