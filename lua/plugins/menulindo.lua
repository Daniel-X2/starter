
return {
  

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        code_action = {
          num_shortcut = true,
          show_server_name = true,
          extend_gitsigns = true,
          keys = {
            quit = "q",
            exec = "<CR>",
          },
        },
        lightbulb = {
          enable = true,
          sign = true,
          virtual_text = true,
        },
      })
    end,
  },

  

}
