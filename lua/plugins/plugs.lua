return {
  --nuevo tema
	--VIM: TOGGLETERM
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
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufNewFile" },
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
			vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<cr>", {})
			vim.keymap.set("n", "]h", ":Gitsigns next_hunk<cr>", {})
			vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<cr>", {})
			vim.keymap.set("n", "<leader>hb", ":Gitsigns toggle_current_line_blame<cr>", {})
			vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<cr>", {})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gg", ":Git<cr>", {})
			vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", {})
		end,
	},
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "http",
		config = function()
			require("rest-nvim").setup({
				result_split_horizontal = false,
				result_split_in_place = false,
				stay_in_current_window_after_split = false,
				jump_to_request = true,
				highlight = {
					enabled = true,
					timeout = 120,
				},
				result = {
					show_url = true,
					show_curl_command = false,
					show_http_info = false,
					show_headers = true,
					show_statistics = false,
				},
			})
			vim.keymap.set("n", "<leader>rr", require("rest-nvim").run, { desc = "[R]est [R]un" })
		end,
	},
}
