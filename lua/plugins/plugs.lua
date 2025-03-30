return {
  --VIM: KULALA
  {
    'mistweaverco/kulala.nvim',
    config = function()
      local kulala = require('kulala');
      kulala.setup({
        default_view = 'verbose'
      })
      vim.keymap.set("n", "<leader>kr", "<cmd>lua require('kulala').run()<cr>")
      vim.keymap.set("n", "<leader>kt", "<cmd>lua require('kulala').toggle_view()<cr>")
      vim.keymap.set("n", "<leader>ki", "<cmd>lua require('kulala').inspect()<cr>")
      vim.keymap.set("n", "<leader>kc", "<cmd>lua require('kulala').copy()<cr>")
      vim.keymap.set("n", "<leader>ka", "<cmd>lua require('kulala').jump_prev()<cr>")
      vim.keymap.set("n", "<leader>ks", "<cmd>lua require('kulala').jump_next()<cr>")
    end
  },
  --VIM: SUPERMAVEN
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },
  {
    'nvim-java/nvim-java',
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require('java').setup()
      require('lspconfig').jdtls.setup({})
    end
  },
  {
    "saghen/blink.cmp",
    enabled = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
      keymap = {preset ="default"},
      signature = { enabled = true },
    },
  },
}
