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
				dashboard.button("SPC SPC", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
				dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
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
    enabled = false,
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					tab_size = 20,
					style_preset = require("bufferline").style_preset.no_italic,
					show_buffer_close_icons = false,
					truncate_names = true,
					color_icons = true,
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
	--VIM: NOTIFY
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			notify.setup({
				render = "minimal",
			})
		end,
	},
}
