return{ --tudo ok
    "romgrk/barbar.nvim",
    dependencies = { "nvim-web-devicons", "nvim-lua/plenary.nvim" },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require("barbar").setup({})
    end,
  }