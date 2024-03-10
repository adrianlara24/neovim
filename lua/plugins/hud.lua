return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"romgrk/barbar.nvim",
		event = "BufReadPre",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = true
		end,
		opts = {
			animation = true,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "catppuccin",
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				backdrop = 0.8,
				width = 400,
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
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				autochdir = true,
				direction = "horizontal",
				hide_number = false,
				shell = vim.o.shell,
				auto_scroll = true,
				on_create = function()
					local opts = { buffer = 0 }
					vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "<a-h>", [[<Cmd>wincmd h<CR>]], opts)
					vim.keymap.set("t", "<a-j>", [[<Cmd>wincmd j<CR>]], opts)
					vim.keymap.set("t", "<a-k>", [[<Cmd>wincmd k<CR>]], opts)
					vim.keymap.set("t", "<a-l>", [[<Cmd>wincmd l<CR>]], opts)
					vim.keymap.set("t", "<a-w>", [[<C-\><C-n><C-w>]], opts)
				end,
			})
		end,
	},
	{
		"vigoux/notifier.nvim",
		config = function()
			require("notifier").setup({
				components = {
					"nvim",
					"lsp",
				},
			})
		end,
	},
}
