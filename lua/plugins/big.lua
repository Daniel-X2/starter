return{
  "LunarVim/bigfile.nvim",
  event = "BufReadPre",
  opts = {
    filesize = 2, -- tamanho máximo em MB
    pattern = "*", -- aplica para todos os arquivos
    features = {   -- desativa os seguintes recursos
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
    },
  },
}

