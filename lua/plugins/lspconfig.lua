return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
          require("mason").setup()
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
          if not status_ok then
            vim.notify("mason-lspconfig ausente!", vim.log.levels.ERROR)
            return
          end

          mason_lspconfig.setup({
            automatic_installation = { exclude = {} },
          })

          -- Configuração padrão para os servidores instalados
          local lspconfig = require("lspconfig")
          for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
            lspconfig[server].setup({})
          end
        end,
      },
    },
  },
}
