return{ --tudo ok
    "dracula/vim",
    name = "dracula-official",
    config = function()
      vim.cmd("colorscheme dracula")
    end,
  }