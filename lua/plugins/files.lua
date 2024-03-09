return {
	--TELESCOPE
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{
				"nvim-tree/nvim-web-devicons",
				enabled = vim.g.have_nerd_font,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "center",
					path_display = { "absolute" },
					layout_config = {
						mirror = true,
						horizontal = {
							promp_position = "bottom",
						},
					},
					sorting_strategy = "ascending",
					mappings = {
						i = {
							["<c-p>"] = require("telescope.actions.layout").toggle_preview,
							["<c-k>"] = require("telescope.actions").move_selection_previous,
							["<c-j>"] = require("telescope.actions").move_selection_next,
							["<a-j>"] = require("telescope.actions").preview_scrolling_down,
							["<a-k>"] = require("telescope.actions").preview_scrolling_up,
							["<space>"] = require("telescope.actions").select_default,
						},
						n = {
							["<c-p>"] = require("telescope.actions.layout").toggle_preview,
							["<a-j>"] = require("telescope.actions").preview_scrolling_down,
							["<a-k>"] = require("telescope.actions").preview_scrolling_up,
							["<space>"] = require("telescope.actions").select_default,
						},
					},
					preview = {
						hide_on_startup = true,
					},
				},
				extensions = {
					file_browser = {
						initial_mode = "normal",
						mappings = {
							n = {
								["<c-b>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
								["<c-r>"] = require("telescope._extensions.file_browser.actions").goto_cwd,
								["<c-v>a"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
								["<c-f>"] = require("telescope._extensions.file_browser.actions").toggle_browser,
								["<c-t>"] = require("telescope._extensions.file_browser.actions").toggle_all,
								["<c-o>"] = require("telescope._extensions.file_browser.actions").open,
							},
						},
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			pcall(require("telescope").load_extension, "file_browser")
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local file_browser_cmd = ":Telescope file_browser path=%:p:h select_buffer=true<cr>"
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<c-s>", file_browser_cmd, { desc = "[F]ile Browser Folder" })
		end,
	},
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				lsp_file_methods = {
					autosave_changes = true,
				},
				view_options = {
					show_hidden = true,
				},
			})
			vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "OIL open parent directory" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
			vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Lazy Git" })
		end,
	},
}
