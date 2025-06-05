return {
	{
		"nvim-java/nvim-java",
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{ "mistweaverco/kulala.nvim", opts = { default_view = "verbose" } },
	{
		"xiyaowong/transparent.nvim",
		opts = { exclude_groups = { "Float", "StatusLine" } },
	},
	{ "supermaven-inc/supermaven-nvim", opts = {} },
}
