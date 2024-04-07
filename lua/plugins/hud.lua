return {
  -- VIM: DRESSING
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
  -- VIM: DASHBOARD
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
  -- VIM: TREE
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local nvimtree = require("nvim-tree")

			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			nvimtree.setup({
				view = {
					width = 35,
					relativenumber = true,
				},
				-- change folder arrow icons
				renderer = {
					indent_markers = {
						enable = true,
					},
				},
				actions = {
					open_file = {
						window_picker = {
							enable = false,
						},
					},
				},
				filters = {
					custom = { ".DS_Store" },
				},
				git = {
					ignore = false,
				},
			})

			local keymap = vim.keymap
			keymap.set("n", "<S-Tab>", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer" })
			keymap.set("n", "<leader>rt", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
		end,
	},
  -- VIM: BUFFERLINE
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
  -- VIM: LUALINE
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
					lualine_x = {
						{
							"filename",
							color = { fg = "#737994", gui = "bold" },
							path = 1,
						},
					},
				},
				inactive_winbar = {
					lualine_x = {
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
  -- VIM: MAXIMIZER
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>z", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
		},
	},
  -- VIM: INDENT BLANKLINE
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "┊" },
		},
	},
  -- VIM: TOGGLETERM
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
  -- VIM: NOTIFIER
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
