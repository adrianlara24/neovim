return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      local comment = require("Comment")
      comment.setup({
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
        },
      })
    end,
  },
  {
    "m4xshen/autoclose.nvim",
    config = function()
      local autoclose = require("autoclose")
      autoclose.setup({})
    end,
  },
  {
    "filipdutescu/renamer.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local renamer = require("renamer")
      local mappings_utils = require("renamer.mappings.utils")
      renamer.setup({
        mappings = {
          ["<c-j>"] = mappings_utils.set_cursor_to_start,
          ["<c-k>"] = mappings_utils.set_cursor_to_end,
          ["<c-l>"] = mappings_utils.set_cursor_to_word_end,
          ["<c-h>"] = mappings_utils.set_cursor_to_word_start,
          ["<c-c>"] = mappings_utils.clear_line,
        },
      })

      local opts = { noremap = true, silent = true }

      vim.keymap.set("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', opts)
      vim.keymap.set({ "n", "v" }, "<leader>rn", '<cmd>lua require("renamer").rename()<cr>', opts)
    end,
  },
  {
    "github/copilot.vim",
  },
}
