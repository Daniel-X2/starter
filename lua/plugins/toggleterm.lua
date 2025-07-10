return{ --tudo ok por aqui
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-\>]],
        shade_terminals = true,
        shading_factor = 2,
        direction = "horizontal", -- estilo VS Code
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell,
      })
      local Terminal = require("toggleterm.terminal").Terminal
    end,


}
  
