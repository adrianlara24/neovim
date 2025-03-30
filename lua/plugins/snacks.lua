return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      focus = "list",
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    },
    terminal = {
      enabled = true,
      shell = "pwsh.exe",
    }

  },
  keys = {
    { "<leader>,",       function() Snacks.picker.buffers() end },
    { "<leader>/",       function() Snacks.picker.grep({ focus = "input" }) end, },
    { "<leader>n",       function() Snacks.picker.notifications() end, },
    { "<tab>",           function() Snacks.explorer() end, },
    --%:p:h select_buffer=true
    -- { "<tab>",           function() Snacks.picker.files({ cwd = "%:p:h" }) end, },
    -- { "<tab>",           function() Snacks.picker.autocmds({ cwd = vim.lsp.buf.code_action() }) end, },
    { "<leader><space>", function() Snacks.picker.files({ focus = "input" }) end, },
    { "<leader>fp",      function() Snacks.picker.projects() end,                 desc = "Projects" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                   desc = "Recent" },
    { "<leader>fk",      function() Snacks.picker.keymaps() end,                  desc = "Recent" },
    -- git
    { "<leader>gb",      function() Snacks.picker.git_branches() end,             desc = "Git Branches" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,                  desc = "Git Log" },
    { "<leader>gL",      function() Snacks.picker.git_log_line() end,             desc = "Git Log Line" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,               desc = "Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_stash() end,                desc = "Git Stash" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,                 desc = "Git Diff (Hunks)" },
    { "<leader>gf",      function() Snacks.picker.git_log_file() end,             desc = "Git Log File" },
    -- Grep
    { "<leader>sb",      function() Snacks.picker.lines() end,                    desc = "Buffer Lines" },
    { "<leader>sB",      function() Snacks.picker.grep_buffers() end,             desc = "Grep Open Buffers" },
    { "<leader>sg",      function() Snacks.picker.grep() end,                     desc = "Grep" },
    { "<leader>sw",      function() Snacks.picker.grep_word() end,                desc = "Visual selection or word", mode = { "n", "x" } },
    -- Search
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,              desc = "Diagnostics" },
    -- LSP
    -- { "gd",              function() Snacks.picker.lsp_definitions() end,          desc = "Goto Definition" },
    -- { "gD",              function() Snacks.picker.lsp_declarations() end,         desc = "Goto Declaration" },
    -- { "gr",              function() Snacks.picker.lsp_references() end,           nowait = true,                     desc = "References" },
    -- { "gI",              function() Snacks.picker.lsp_implementations() end,      desc = "Goto Implementation" },
    -- { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,              desc = "LSP Symbols" },
    -- Other
    { "<leader>n",       function() Snacks.notifier.show_history() end, },
    { "<leader>bb",      function() Snacks.bufdelete() end,                       desc = "Delete Buffer" },
    { "<leader>bo",      function() Snacks.bufdelete.other() end,                 desc = "Delete Buffer" },
    { "<leader>rf",      function() Snacks.rename.rename_file() end,              desc = "Rename File" },
    { "<leader>gb",      function() Snacks.gitbrowse() end,                       desc = "Git Browse",               mode = { "n", "v" } },
    { "<leader>gg",      function() Snacks.lazygit() end,                         desc = "Lazygit" },
    { "<c-]>",           function() Snacks.terminal.toggle() end, },
    { "]]",              function() Snacks.words.jump(vim.v.count1) end,          desc = "Next Reference",           mode = { "n", "t" } },
    { "[[",              function() Snacks.words.jump(-vim.v.count1) end,         desc = "Prev Reference",           mode = { "n", "t" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.zoom():map("<s-z>")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<s-w>")
        Snacks.toggle.diagnostics():map("<s-d>")
        Snacks.toggle.line_number():map("<s-n>")
        Snacks.toggle.option("relativenumber"):map("<s-n>r")
        Snacks.toggle.option("background", { off = "light", on = "dark" }):map("<s-b>")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<s-i>")
        Snacks.toggle.dim():map("<s-m>")

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
      end,
    })
  end,
}

-- config = function()
--   require("snacks").setup({
--     dim = {
--       enabled = false,
--     },
--     indent = {
--       enabled = false,
--     },
--     quickfix = {
--       enabled = true,
--     },
--     scroll = {
--       enabled = true,
--     },
--     statuscolumn = {
--       enabled = true,
--     },
--     explorer = {
--       replace_netrw = true,
--     },
--     lazygit = {
--       enabled = true,
--     },
--     zen = {
--       enabled = true,
--     },
--     toggle = {
--       enabled = true,
--     },
--     terminal = {
--       enabled = true,
--       shell = "pwsh.exe",
--     },
--
--     picker = {
--       sources = {
--         explorer = {}
--       }
--     },
--   })
--
--   -- buffer delete mappings
--   vim.keymap.set("n", "bq", "<cmd>lua Snacks.bufdelete.delete()<cr>")
--   vim.keymap.set("n", "bo", "<cmd>lua Snacks.bufdelete.other()<cr>")
--   vim.keymap.set("n", "ba", "<cmd>lua Snacks.bufdelete.all()<cr>")
--
--   -- dim mappings
--   local dimEnabled = false
--   vim.keymap.set("n", "<s-d>", function()
--     if dimEnabled then
--       Snacks.dim.disable()
--       dimEnabled = false
--     else
--       Snacks.dim.enable()
--       dimEnabled = true
--     end
--   end)
--
--
--   -- indent mappings
--   local indentEnabled = false
--   vim.keymap.set("n", "<s-i>", function()
--     if indentEnabled then
--       Snacks.indent.disable()
--       indentEnabled = false
--     else
--       Snacks.indent.enable()
--       indentEnabled = true
--     end
--   end)
--
--   -- explorer mappings
--   vim.keymap.set("n", "<tab>", "<cmd>lua Snacks.explorer()<CR>")
--
--   -- lazygit mappings
--   vim.keymap.set("n", "<leader>gg", "<cmd>lua Snacks.lazygit()<CR>")
--
--   -- terminal mappings
--   vim.keymap.set("n", "<C-]>", "<cmd>lua Snacks.terminal.toggle()<CR>")
--
--   -- zen mappings
--   vim.keymap.set("n", "<s-z>", "<cmd>lua Snacks.zen.zoom()<CR>")
--
--   -- zen mappings
--   vim.keymap.set("n", "<leader><space>", "<cmd>lua Snacks.picker.buffers()<CR>")
--   vim.keymap.set("n", "<leader><space>", "<cmd>lua Snacks.picker.buffers()<CR>")
-- end
