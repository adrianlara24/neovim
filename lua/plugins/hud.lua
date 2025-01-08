return {
	--VIM: DRESSING
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	--VIM: TREE
	{
		"preservim/nerdtree",
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			local keymap = vim.keymap
			keymap.set("n", "<S-Tab>", "<cmd>NERDTreeToggle<CR>", { desc = "Toggle file explorer" })
		end,
	},
	--VIM: LUALINE
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					component_separators = "",
					globalstatus = false,
					refresh = {
						winbar = 100,
					},
				},

				winbar = {
					lualine_c = {
						{
							"filename",
							color = { fg = "#eaeaea", gui = "bold", bg = "transparent" },
							path = 1,
						},
					},
				},
				inactive_winbar = {
					lualine_c = {
						{
							"filename",
							color = { fg = "#eaeaea", gui = "bold", bg = "transparent" },
							path = 1,
						},
					},
				},
			})
		end,
	},
	--VIM: MAXIMIZER
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				width = 1,
				height = 1,
			},
			plugins = {
				lualine = { enabled = true },
			},
		},
		keys = {
			{ "<A-w>z", "<cmd>ZenMode<CR>", desc = "Zen mode" },
		},
	},
	--VIM: INDENT BLANKLINE
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "┊" },
		},
	},
}
