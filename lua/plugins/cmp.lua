return {
  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- LSP core
  "neovim/nvim-lspconfig",

  -- LSP installer automático
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Linters / Formatadores como LSP (ex: prettier, black)
  
}
