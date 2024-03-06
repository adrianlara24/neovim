return {
	--TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- event = { "BufReadPre", "BufNewFile" },
		event = "VeryLazy",
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				ensure_installed = {
					"angular",
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"json",
					"lua",
					"c_sharp",
					"rust",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				auto_install = true,
			})
		end,
	},

	--CMP
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<c-k>"] = cmp.mapping.select_prev_item(),
					["<c-j>"] = cmp.mapping.select_next_item(),
					["<c-b>"] = cmp.mapping.scroll_docs(-4),
					["<c-f>"] = cmp.mapping.scroll_docs(4),
					["<c-space>"] = cmp.mapping.complete(),
					["<c-e>"] = cmp.mapping.abort(),
					["<cr>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			luasnip.filetype_extend("angular", { "html" })
		end,
	},

	--MASON
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

			mason.setup({})
			mason_lspconfig.setup({
				ensure_installed = {
					"tsserver",
					"angularls",
					"html",
					"cssls",
					"tailwindcss",
					"emmet_ls",
					"lua_ls",
					"csharp_ls",
				},
				automatic_installation = true,
			})
			vim.keymap.set(
				"n",
				"<leader>m",
				":Mason<cr>",
				{ noremap = true, silent = true, desc = "MASON open config" }
			)
		end,
	},

	--LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local keymap = vim.keymap
			local opts = { noremap = true, silent = true }
			local on_attach = function(_, bufnr)
				opts.buffer = bufnr

				opts.desc = "LSP format"
				keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, opts)

				opts.desc = "LSP show lsp references"
				keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", opts)

				opts.desc = "LSP go to declaration"
				keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)

				opts.desc = "LSP go to definitions"
				keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", opts)

				opts.desc = "LSP show implementations"
				keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", opts)

				opts.desc = "LSP code actions"
				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_actions, opts)

				--opts.desc = "LSP rename"
				--keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				--opts.desc = "LSP show buffer diagnostic"
				--keymap.set("n", "<leader>[d", "<cmd>Telescope diagnostic bufnr=0<cr>", opts)

				--opts.desc = "LSP show line diagnostic"
				--keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "LSP info"
				keymap.set("n", "<leader>lI", ":LspInfo<cr>", opts)

				opts.desc = "LSP restart"
				keymap.set("n", "<leader>ll", ":LspRestart<cr>", opts)
			end

			local capabilities = cmp_nvim_lsp.default_capabilities()

			lspconfig["html"].setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig["tsserver"].setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig["tailwindcss"].setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig.angularls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "angular", "html", "typescript", "typescriptreact" },
			})
			lspconfig["cssls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "typescript", "javascript", "css", "scss" },
			})
			lspconfig["emmet_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "typescript", "javascript", "css", "scss" },
			})
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							libary = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})
			lspconfig["csharp_ls"].setup({ capabilities = capabilities, on_attach = on_attach })
		end,
	},

	--NONE_LS
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd.with({
						extra_filetypes = { "angular" },
					}),
				},
			})
		end,
	},
}
