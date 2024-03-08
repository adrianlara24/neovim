return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			local comment = require("Comment")
			comment.setup({
				toggler = {
					line = "<leader>cl",
					block = "<leader>cb",
				},
				opleader = {
					line = "<leader>cl",
					block = "<leader>cb",
				},
				mappings = {
					basic = true,
				},
			})
		end,
	},
	{
		"m4xshen/autoclose.nvim",
		config = function()
			local autoclose = require("autoclose")
			autoclose.setup({})
		end,
	},
	{
		"filipdutescu/renamer.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local renamer = require("renamer")
			local mappings_utils = require("renamer.mappings.utils")
			renamer.setup({
				mappings = {
					["<c-d>"] = mappings_utils.clear_line,
				},
			})

			local opts = { noremap = true, silent = true }

			vim.keymap.set("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', opts)
			vim.keymap.set({ "n", "v" }, "<leader>rn", '<cmd>lua require("renamer").rename()<cr>', opts)
		end,
	},
	{
		"github/copilot.vim",
	},
}
