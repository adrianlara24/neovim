return {
	{
		"stevearc/dressing.nvim",
		config = true,
	},
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
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					component_separators = "|",
					globalstatus = false,
					refresh = {
						winbar = 100,
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{ "mode", color = { bg = "#dce0e8", fg = "#232634", gui = "bold" } },
						{ "branch", color = { fg = "#dce0e8", gui = "bold" } },
						{ "diff" },
					},
					lualine_x = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = "error:", warn = "warn:", info = "info:" },
						},
						{
							"filename",
							color = { fg = "#7287fd", gui = "bold" },
							path = 1,
						},
					},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
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
	{
		"preservim/nerdtree",
		config = function()
			vim.keymap.set("n", "<S-Tab>", ":NERDTreeToggle<cr>", {})
		end,
	},
}
