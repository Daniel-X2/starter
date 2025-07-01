-- bootstrap lazy.nvim, LazyVim and your plugins
-- Desativa o F1 no modo normal e inserção
vim.keymap.set({ "n", "i" }, "<F1>", "<Nop>", { silent = true })


vim.keymap.set("n", "<F2>", "<nop>")

require("config.lazy")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Se nenhum arquivo foi aberto (nenhum argumento passado)
    if vim.fn.argc() == 0 then
      -- Abre o dashboard
      vim.cmd("Dashboard")
    end
  end,
})

--tira o map do f1
vim.keymap.set({ "n","i"}, "<F3>", function()
  vim.cmd("Dashboard")
end, { silent = true })
-- Copiar com Ctrl+C no modo visual
--
vim.keymap.set("v", "<C-c>", '"+y')

-- Colar com Ctrl+V no modo normal
vim.keymap.set("n", "<C-v>", '"+p')

-- Colar com Ctrl+V no modo inserção
vim.keymap.set("i", "<C-v>", '<Esc>"+pa')

--aqui configura pra assim que abrir um arquivo ficar no insert
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if vim.fn.expand("<afile>") ~= "" then
      vim.cmd("startinsert")
    end
  end,
})
--aqui faz o cursor deixar de ficar com raio
if vim.g.neovide then
  vim.g.neovide_cursor_trail_size = 5
end
--aqui tira as viadagem dos numeros
vim.opt.number = true -- mostra números de linha absolutos
vim.opt.relativenumber = false -- garante que não sejam relativos
vim.o.mousemoveevent = true


vim.opt.termguicolors = true

--coisa o terminal e coloca mapeamento

local Terminal = require("toggleterm.terminal").Terminal

-- Terminal com ID fixo
local term = Terminal:new({
  direction = "horizontal",
  hidden = true,
  id = 1,
})

-- Mapeia F1 para abrir/fechar com reset
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




local M = {}

M.create_new_project = function()
  local input = vim.fn.input("Nome do novo projeto: ")
  if input == nil or input == "" then
    print("Nome inválido.")
    return
  end

  local root = vim.fn.expand("~/Projects") -- você pode mudar isso
  local path = root .. "/" .. input

  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
    print("Projeto criado em " .. path)
  else
    print("Projeto já existe!")
  end

  vim.cmd("cd " .. path)
  require("telescope.builtin").find_files({ cwd = path })
end

return M
