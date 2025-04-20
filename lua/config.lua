local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.updatetime = 250
opt.timeoutlen = 300
opt.scrolloff = 10
opt.textwidth = 200
opt.wrap = false
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true
opt.cursorline = true
opt.autoindent = true
opt.termguicolors = true
opt.swapfile = false

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = false
vim.o.relativenumber = false

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
