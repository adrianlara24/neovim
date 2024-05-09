return {
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
  -- VIM: GITSIGNS
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
      local gitsigns = require("gitsigns")
			gitsigns.setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
			vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<cr>", { desc = "Gitsigns previous hunk" })
			vim.keymap.set("n", "]h", ":Gitsigns next_hunk<cr>", { desc = "Gitsigns next hunk" })
			vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<cr>", { desc = "Gitsigns preview hunk" })
			vim.keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<cr>", { desc = "Gitsigns stage hunk" })
			vim.keymap.set("n", "<leader>hu", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Gitsigns undo hunk" })
			vim.keymap.set(
				"n",
				"<leader>hb",
				":Gitsigns toggle_current_line_blame<cr>",
				{ desc = "Gitsigns toggle blame line" }
			)
			vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<cr>", { desc = "Gitsigns diff this" })
		end,
	},
  -- VIM: FUGITIVE
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gg", ":Git<cr>", {})
			vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", {})
		end,
	},
}
