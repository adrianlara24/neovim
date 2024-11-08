--TODO: fix autoclose tags to work with js and ts
--TODO: lualine reconfigure
--TODO: add rest and db plugins

vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
local g = vim.g
local o = vim.o
local keymap = vim.keymap

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
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"

g.mapleader = " "
g.maplocalleader = " "

o.number = true
o.relativenumber = false

keymap.set("n", "<A-a>", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<A-s>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<A-q>", "<cmd>bd<CR>", { desc = "Close buffer" })
keymap.set("n", "<A-q>q", "<cmd>bd!<CR>", { desc = "Close buffer force" })
keymap.set("n", "<A-q>s", "<cmd>close<CR>", { desc = "Close buffer force" })
keymap.set("n", "<A-1>", "<cmd>vsplit<CR>", { desc = "Split vertically" })
keymap.set("n", "<A-2>", "<cmd>split<CR>", { desc = "Split horizontally" })
keymap.set("n", "<A-h>", "<C-w>h", { desc = "Move to left buffer" })
keymap.set("n", "<A-j>", "<C-w>j", { desc = "Move to bottom buffer" })
keymap.set("n", "<A-k>", "<C-w>k", { desc = "Move to top buffer" })
keymap.set("n", "<A-l>", "<C-w>l", { desc = "Move to right buffer" })
keymap.set("n", "<A-e>e", "<cmd>qa!<CR>", { desc = "Close all buffers" })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Load lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

vim.api.nvim_command("colorscheme rose-pine-moon")
