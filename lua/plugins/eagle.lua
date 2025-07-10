return 
{ --aqui esta ok
    "soulis-1256/eagle.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("eagle").setup({})
    end,
  }