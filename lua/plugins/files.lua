return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", {})
			vim.keymap.set("n", "<leader>ga", ":Gitsigns toggle_current_line_blame<cr>", {})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gg", ":Git<cr>", {})
			vim.keymap.set("n", "<leader>gc", ":Git commit<cr>", {})
			vim.keymap.set("n", "<leader>gp", ":Git pull<cr>", {})
			vim.keymap.set("n", "<leader>gP", ":Git push<cr>", {})
			vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", {})
		end,
	},
}
