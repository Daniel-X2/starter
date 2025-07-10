return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- carrega antes de abrir buffer
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- pasta das sessões
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })
    end,
  }