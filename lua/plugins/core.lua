return {
  --VIM: AUTO SESSION
  {
    "rmagatti/auto-session",
    config = function()
      local auto_session = require("auto-session")

      auto_session.setup({
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
        log_level = "error",
      })

      local keymap = vim.keymap


      keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
      keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
    end,
  },
  --VIM: OIL
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    config = function()
      local oil = require('oil')
      oil.setup({
        use_default_keybindings = false,
        view_options = {
          show_hidden = true,
        },
        float = {
          padding = 0,
          max_width = 0.8,
          max_height = 0.8,
          border = "single",
          preview_split = "auto",
          win_options = {
            winblend = 0,
          }
        },
        keymaps = {
          ["q"] = "actions.close",
          ["<space>"] = "actions.select",
          ["<C-r>"] = "actions.open_cwd",
          ["<C-p>"] = "actions.preview",
          ["<A-1>"] = { "actions.select", opts = { vertical = true } },
          ["<A-2>"] = { "actions.select", opts = { horizontal = true } },
          ["?"] = "actions.show_help",
        },
      })
      -- vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open oil" })
      vim.keymap.set("n", "<leader>o", function() oil.open_float() end, { desc = "Open oil" })
    end,
  },
  --VIM: SNIPE
  {
    "leath-dub/snipe.nvim",
    config = function()
      local snipe = require("snipe")
      snipe.setup({
        ui = {
          position = "center",
        },
        navigate = {
          cancel_snipe = "<esc>",
          close_buffer = "D",
          open_vsplit = "1",
          open_split = "2",
        },
      })
      vim.keymap.set("n", "<leader>s", snipe.open_buffer_menu, { desc = "Open snipe buffer menu" })
    end
  },
}
