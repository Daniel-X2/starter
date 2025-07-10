return {
  {
    "ojroques/nvim-lspfuzzy",
    dependencies = { "junegunn/fzf", "junegunn/fzf.vim" },
    config = function()
      require("lspfuzzy").setup({})
    end,
  },
}