vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.textwidth = 200
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true
vim.o.relativenumber = false

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<A-h>", "<cmd>bprev<CR>", opts)
map("n", "<A-l>", "<cmd>bnext<CR>", opts)
map("n", "<A-j>", "<cmd>bfirst<CR>", opts)
map("n", "<A-k>", "<cmd>blast<CR>", opts)
vim.keymap.set({ "n", "v" }, "<A-q>", "<cmd>bd<CR>", {})

map("n", "<leader>=", ":vsplit<CR>", opts)
map("n", "<leader>-", ":split<CR>", opts)
map("n", "<A-w>h", "<C-w>h", {})
map("n", "<A-w>j", "<C-w>j", {})
map("n", "<A-w>k", "<C-w>k", {})
map("n", "<A-w>l", "<C-w>l", {})

vim.keymap.set({ "n", "v" }, "<A-q>q", ":qa!<cr>", { desc = "Close NeoVim Foce" })

-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	desc = "Highlight when yanking (copying) text",
-- 	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- })

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

require("lazy").setup("plugins", {})
