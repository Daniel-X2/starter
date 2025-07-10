-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.showmode = false       -- esconde o modo (INSERT, NORMAL, etc.)
vim.opt.ruler = false          -- esconde as coordenadas
vim.opt.number = true -- mostra números de linha absolutos
vim.opt.relativenumber = false -- garante que não sejam relativos
vim.o.mousemoveevent = true

if vim.g.neovide then
  vim.g.neovide_cursor_trail_size = 5
end
vim.opt.termguicolors = true

vim.cmd.colorscheme("dracula") -- garanta que o tema está carregado antes

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#bd93f9", bold = true })   -- Roxo Dracula
vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#50fa7b" })                -- Verde Dracula
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#ff79c6", italic = true }) -- Rosa Dracul
require("lspconfig").pyright.setup({
  on_attach = function(client, bufnr)
    -- Não chame signature_help aqui!
    -- Só o lsp_signature já cuida disso
  end,
})



-- Define os ícones na margem


