return {
	--VIM: DRESSING
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	--VIM: DASHBOARD
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
				dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
				dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
				dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
				dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
			}

			-- Send config to alpha
			alpha.setup(dashboard.opts)

			-- Disable folding on alpha buffer
			vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		end,
	},
	--VIM: TREE
	{
		"preservim/nerdtree",
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			local keymap = vim.keymap
			keymap.set("n", "<S-Tab>", "<cmd>NERDTreeToggle<CR>", { desc = "Toggle file explorer" })
			-- keymap.set("n", "<leader>rt", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
		end,
	},
	--VIM: BUFFERLINE
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					tab_size = 20,
					style_preset = require("bufferline").style_preset.no_italic,
					show_buffer_close_icons = false,
					truncate_names = true,
					color_icons = false,
					separator_style = "thin",
					diagnostics = "nvim_lsp",
					indicator = {
						style = "none",
					},
				},
			})
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
							color = { fg = "#737994", gui = "bold" },
							path = 1,
						},
					},
				},
				inactive_winbar = {
					lualine_c = {
						{
							"filename",
							color = { fg = "#737994", gui = "bold" },
							path = 1,
						},
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"mode",
							color = function()
								local colors = {
									n = "#ca9ee6",
									i = "#a6d189",
									v = "#8caaee",
									V = "#8caaee",
								}
								return { bg = colors[vim.fn.mode()], fg = "#232634", gui = "bold" }
							end,
						},
						{ "branch", color = { fg = "#cad3f5", gui = "bold" } },
						{ "diff" },
					},
					lualine_x = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = "error:", warn = "warn:", info = "info:" },
						},
					},
					lualine_y = {},
					lualine_z = {},
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
			{ "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen mode" },
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
	--VIM: NOTIFIER
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
