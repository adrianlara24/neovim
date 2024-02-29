return {
  --TELESCOPE
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local telescope = require("telescope")
			local telescope_actions = require("telescope.actions")
			local keymap = vim.api.nvim_set_keymap

			telescope.setup({
				defaults = {
					layout_strategy = "vertical",
					path_display = { "absolute" },
					mappings = {
						i = {
							["<c-k>"] = telescope_actions.move_selection_previous,
							["<c-j>"] = telescope_actions.move_selection_next,
						},
					},
				},
				pickers = {
					find_files = {
						previewer = false,
					},
					buffers = {
						previewer = false,
						path_display = { "absolute" },
					},
					oldfiles = {
						previewer = false,
					},
					file_browser = {
						layout_strategy = "horizontal",
					},
				},
				extensions = {
					file_browser = {
						-- theme = "ivy",
						hijack_netrw = true,
					},
				},
			})

			require("telescope").load_extension("file_browser")

			keymap(
				"n",
				"<leader><leader>",
				"<cmd>Telescope find_files<cr>",
				{ noremap = true, silent = true, desc = "TS find file" }
			)
			keymap(
				"n",
				"<leader>ft",
				"<cmd>Telescope buffers<cr>",
				{ noremap = true, silent = true, desc = "TS find open file" }
			)
			keymap(
				"n",
				"<leader>fr",
				"<cmd>Telescope oldfiles<cr>",
				{ noremap = true, silent = true, desc = "TS view old files" }
			)
			keymap(
				"n",
				"<leader>fg",
				"<cmd>Telescope live_grep<cr>",
				{ noremap = true, silent = true, desc = "TS grep" }
			)
			keymap(
				"n",
				"<leader>fh",
				"<cmd>Telescope help_tags<cr>",
				{ noremap = true, silent = true, desc = "TS help tags" }
			)
			keymap(
				"n",
				"<leader>fc",
				"<cmd>Telescope colorscheme<cr>",
				{ noremap = true, silent = true, desc = "TS color schemes" }
			)
			keymap(
				"n",
				"<leader>fk",
				"<cmd>Telescope keymaps<cr>",
				{ noremap = true, silent = true, desc = "TS keymaps" }
			)
			keymap(
				"n",
				"<leader>fb",
				":Telescope file_browser<cr>",
				{ noremap = true, silent = true, desc = "TS file browser" }
			)
			keymap(
				"n",
				"<leader>ff",
				":Telescope file_browser path=%:p:h select_buffer=true<cr>",
				{ noremap = true, silent = true, desc = "TS file browser in folder" }
			)
		end,
	},
	{
		"stevearc/oil.nvim",
		config = function()
			local config = require("oil")
			config.setup({
				lsp_rename_autosave = true,
				view_options = {
					show_hidden = true,
				},
			})
			vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "OIL open parent directory" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},
}
