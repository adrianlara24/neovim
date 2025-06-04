return {
	{
		"nvim-java/nvim-java",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("java").setup()
			require("lspconfig").jdtls.setup({})
		end,
	},
	{ "mistweaverco/kulala.nvim", opts = { default_view = "verbose" } },
	{
		"xiyaowong/transparent.nvim",
		opts = { exclude_groups = { "Float", "StatusLine" } },
	},
	{ "supermaven-inc/supermaven-nvim", opts = {} },
}
