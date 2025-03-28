return {
  --VIM: TOGGLETERM
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        autochdir = true,
        hide_number = false,
        shell = "pwsh.exe -NoExit -File C:\\Users\\adria\\Documents\\PowerShell\\Microsoft.PowerShell_profile.ps1",
        auto_scroll = true,
        direction = "horizontal",
        on_create = function()
          local opts = { buffer = 0 }
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "<a-h>", [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set("t", "<a-j>", [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set("t", "<a-k>", [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set("t", "<a-l>", [[<Cmd>wincmd l<CR>]], opts)
          vim.keymap.set("t", "<a-w>", [[<C-\><C-n><C-w>]], opts)
        end,
      })
    end,
  },
  --VIM: LAZYGIT
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
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
  }
}
