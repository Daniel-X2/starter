

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})




vim.keymap.set("n", "<F7>", function()
  require("sidebar").toggle_sidebar()
end, { noremap = true, silent = true })


-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "i" }, "<F1>", "<Nop>", { silent = true })
vim.keymap.set("n", "<F2>", "<nop>")
--aqui abre o dashboard
vim.keymap.set({ "n","i"}, "<F3>", function()
  vim.cmd("Dashboard")
end, { silent = true })




vim.keymap.set({"n","i"}, '<F5>', "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.keymap.set({"i","n"}, '<F6>', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })

-- Copiar com Ctrl+C no modo visual
--
vim.keymap.set("v", "<C-c>", '"+y')

-- Colar com Ctrl+V no modo normal
vim.keymap.set("n", "<C-v>", '"+p')

-- Colar com Ctrl+V no modo inserção
vim.keymap.set("i", "<C-v>", '<Esc>"+pa')

-- Mapeia F1 para abrir/fechar com reset
local Terminal = require("toggleterm.terminal").Terminal
-- Terminal com ID fixo
local term = Terminal:new({
  direction = "horizontal",
  hidden = true,
  id = 1,
})
vim.keymap.set({"n","i"} ,"<F1>", function()
  if term:is_open() then
    term:shutdown() -- Fecha e reseta o terminal (mata o buffer)
  else
    term:open() -- Abre limpo
  end
end, { noremap = true, silent = true })

--aqui coisa o neo tree
vim.keymap.set({"n","i"}, "<F2>", function()
  require("neo-tree.command").execute({ toggle = true })
end, { noremap = true, silent = true })

vim.api.nvim_create_user_command("RestoreSession", function()
  require("persistence").load()
end, {})
