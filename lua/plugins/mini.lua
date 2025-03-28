return {
  {
    'echasnovski/mini.cursorword',
    version = '*',
    config = function()
      require('mini.cursorword').setup()
    end
  },
  {
    'echasnovski/mini.statusline',
    version = '*',
    config = function()
      require('mini.statusline').setup()
    end
  },
  {
    'echasnovski/mini.jump',
    version = '*',
    config = function()
      require('mini.jump').setup()
    end
  },
  {
    'echasnovski/mini.jump2d',
    version = '*',
    config = function()
      require('mini.jump2d').setup({
        mappings = {
          start_jumping = 's',
        }
      })
    end
  },
  {
    'echasnovski/mini.notify',
    version = '*',
    config = function()
      require('mini.notify').setup({
        lsp_progress = {
          enable = true,
          level = "INFO",
          duration_last = 600,
        }
      })
    end
  },
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup()
      vim.keymap.set('n', '<tab><tab>', '<cmd>lua MiniFiles.open()<cr>')
    end
  },
}
