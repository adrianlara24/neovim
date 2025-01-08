--VIM: THEMES
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        default_integrations = true,
        integrations = {
          cmp = true,
          nvimtree = true,
          treesitter = true,
          gitsigns = true,
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      local rose_pine = require("rose-pine")
      rose_pine.setup({
        variant = "moon",
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "savq/melange-nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "kdheepak/monochrome.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "maxmx03/fluoromachine.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local fm = require("fluoromachine")
      fm.setup({
        glow = true,
      })
    end,
  },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
}
