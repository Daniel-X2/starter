return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "json" }, -- adicione as linguagens que quiser
      }
    end,
  },
}