return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
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
					transparency = true,
				},
			})
		end,
	},
	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
}
