-- bootstrap lazy.nvim, LazyVim and your plugins
-- init.lua
vim.env.LANG = "pt_BR.UTF-8"
vim.env.LC_ALL = "pt_BR.UTF-8"
vim.env.LC_MESSAGES = "pt_BR.UTF-8"
vim.o.mouse = "a"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})


require("config.lazy")

require("config.keymaps")
require("config.options")
require("config.sinais")
require("config.autocmds")
require("projetos.project")

require("config.lsp")
require("config.cmp")
require("config.lualine")



