return {
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
			vim.keymap.set("n", "<leader>rl", require("rest-nvim").last, { desc = "[R]est [R]un [L]ast" })
		end,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{
				"tpope/vim-dadbod",
				lazy = true,
			},
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = { "sql", "mysql", "plsql" },
				lazy = true,
			},
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- local function db_completion()
			-- 	require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
			-- end
			-- vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"
			--
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = {
			-- 		"sql",
			-- 	},
			-- 	command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
			-- })
			--
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = {
			-- 		"sql",
			-- 		"mysql",
			-- 		"plsql",
			-- 	},
			-- 	callback = function()
			-- 		vim.schedule(db_completion)
			-- 	end,
			-- })

			vim.keymap.set("n", "<c-]>", ":DBUIToggle<cr>", {})
		end,
	},
}
