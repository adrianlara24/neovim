local map = vim.keymap.set
local opts = { noremap = true, silent = true, }
local files_config = { focus = 'input', preview = false, layout = { preset = 'vscode' }, }
local quick_explorer_config = {
  title = 'Quick Explorer',
  replace_netrw = false,
  layout = { preset = 'vscode' },
  formatters = {
    file = { git_status_hl = false, },
  },
  diagnostics = false,
  git_status = false,
  auto_close = true,
}

-- CORE
map("n", "<a-a>", "<cmd>vsplit<cr>", opts)
map("n", "<a-s>", "<cmd>split<cr>", opts)
map("n", "<a-q>", "<cmd>q<cr>", opts)
map("n", "<a-h>", "<c-w>h", opts)
map("n", "<a-j>", "<c-w>j", opts)
map("n", "<a-k>", "<c-w>k", opts)
map("n", "<a-l>", "<c-w>l", opts)
map("n", "<a-b><c-h>", "<cmd>bfirst<cr>", opts)
map("n", "<a-b><a-j>", "<cmd>bprevious<cr>", opts)
map("n", "<a-b><a-k>", "<cmd>bnext<cr>", opts)
map("n", "<a-b><a-l>", "<cmd>blast<cr>", opts)
map("n", "<a-b><a-q>", "<cmd>bd<cr>", opts)
map("n", "<a-b><a-q>q", "<cmd>bd!<cr>", opts)
map("n", "<a-t><a-n>", "<cmd>tabnew<cr>", opts)
map("n", "<a-t><a-t>", "<cmd>tab split<cr>", opts)
map("n", "<a-t><a-h>", "<cmd>tabfirst<cr>", opts)
map("n", "<a-t><a-j>", "<cmd>tabprevious<cr>", opts)
map("n", "<a-t><a-k>", "<cmd>tabnext<cr>", opts)
map("n", "<a-t><a-l>", "<cmd>tablast<cr>", opts)
map("n", "<a-t><a-q>", "<cmd>tabclose<cr>", opts)
map("n", "<a-e>e", "<cmd>qa!<cr>", opts)

-- SNACKS FINDERS
map("n", "<leader><space>", function() Snacks.picker.files(files_config) end, opts)
map("n", "<leader>,", function() Snacks.picker.grep({ focus = 'input' }) end, opts)
map("n", "<leader>.", function() Snacks.picker.grep_buffers({ focus = 'input' }) end, opts)
map("n", "<leader><tab>", function() Snacks.picker.buffers({ layout = { preset = "vscode", preview = false } }) end, opts)
map("n", "<tab>", function() Snacks.picker.explorer(quick_explorer_config) end, opts)
map("n", "<s-tab>", function() Snacks.explorer() end, opts)

-- SNACKS CONFIG
map("n", "<leader>oc", function() Snacks.picker.colorschemes({ layout = { preset = "vscode", preview = false } }) end, opts)
map("n", "<leader>od", function() Snacks.picker.diagnostics() end, opts)
map("n", "<leader>ok", function() Snacks.picker.keymaps() end, opts)

-- SNACKS GIT
map("n", "<leader>gg", function() Snacks.lazygit() end, opts)
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, opts)
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, opts)
map("n", "<leader>gf", function() Snacks.picker.git_files() end, opts)
map("n", "<leader>gG", function() Snacks.picker.git_grep() end, opts)
map("n", "<leader>gl", function() Snacks.picker.git_log() end, opts)
map("n", "<leader>gs", function() Snacks.picker.git_stash() end, opts)
map("n", "<leader>go", function() Snacks.gitbrowse() end, opts)

-- LSP
map("n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
map("n", "gf", function() require("conform").format({ async = true }) end, opts)
map("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
map("n", "gr", function() Snacks.picker.lsp_references() end, opts)
map("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)
map("n", "gs", function() Snacks.picker.lsp_symbols() end, opts)
map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

-- MISC
map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
map("n", "<leader>j", function() MiniJump2d.start() end, opts)
map("n", "<leader>sr", "<cmd>SessionRestore<cr>", opts)
map("n", "<leader>=", function() require("oil").open_float() end, opts)
map("n", "<c-]>", "<cmd>terminal pwsh.exe<cr>", opts)
map("n", "<c-\\>", function() Snacks.terminal.toggle() end, opts)

-- KULALA
map("n", "<leader>kr", "<cmd>lua require('kulala').run()<cr>")
map("n", "<leader>kt", "<cmd>lua require('kulala').toggle_view()<cr>")
map("n", "<leader>ki", "<cmd>lua require('kulala').inspect()<cr>")
map("n", "<leader>kc", "<cmd>lua require('kulala').copy()<cr>")
map("n", "<leader>ka", "<cmd>lua require('kulala').jump_prev()<cr>")
map("n", "<leader>ks", "<cmd>lua require('kulala').jump_next()<cr>")

-- AFTER LAZY LOADING
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    Snacks.toggle.zoom():map("<s-z>")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<s-w>")
    Snacks.toggle.diagnostics():map("<s-d>")
    Snacks.toggle.line_number():map("<s-n>")
    Snacks.toggle.option("relativenumber"):map("<s-r>")
    Snacks.toggle.option("background", { off = "dark", on = "light" }):map("<s-b>")
    Snacks.toggle.indent():map("<s-i>")
    Snacks.toggle.dim():map("<s-m>")
  end,
})
