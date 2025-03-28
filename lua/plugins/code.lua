return {
  --VIM: CONFORM
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        notify_on_error = true,
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        conform.format({
          lsp_fallback = true,
          async = true,
          -- timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  --VIM: AUTO CLOSE PAIRS
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
        },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  --VIM: COMMENTS
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      comment.setup({
        pre_hook = ts_context_commentstring.create_pre_hook(),
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
          extra = false
        },
      })
    end,
  },
  --VIM: TODO COMMENTS
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local todo_comments = require("todo-comments")
      local keymap = vim.keymap
      keymap.set("n", "]t", function()
        todo_comments.jump_next()
      end, { desc = "Next todo comment" })
      keymap.set("n", "[t", function()
        todo_comments.jump_prev()
      end, { desc = "Previous todo comment" })

      todo_comments.setup({
        signs = false,
        keywords = {
          VIM = { icon = "", color = "#99d1db" },
          FIX = { icon = "", color = "#99d1db" },
          TODO = { icon = "", color = "#99d1db" },
          NOTE = { icon = "", color = "#99d1db" },
        },
        highlight = {
          multiline = false,
          before = "fg",
          keyword = "fg",
          after = "fg",
        },
      })
    end,
  },
  --VIM: SELECT MULTILINE
  {
    "mg979/vim-visual-multi",
  },
}
