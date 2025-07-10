-- Configurações gerais de edição
vim.opt.swapfile = false         -- desativa swap file
vim.opt.backup = false           -- desativa backup
vim.opt.writebackup = false      -- desativa backup na escrita
vim.opt.updatetime = 1000        -- atualiza o arquivo rapidamente
vim.opt.autoread = true          -- habilita recarregar o arquivo modificado fora









local lspconfig = require('lspconfig')

lspconfig.omnisharp.setup({
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  settings = {
    RoslynExtensionsOptions = {
      enableAnalyzersSupport = true,
      language = "pt-BR",
    }
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})















vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold"}, {
  command = "if mode() != 'c' | checktime | endif"
})

-- Abre o buffer no modo insert automaticamente (se buffer válido)
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.defer_fn(function()
      local buftype = vim.bo.buftype
      local file = vim.api.nvim_buf_get_name(0)
      if buftype == "" and file ~= "" then
        vim.cmd("startinsert")
      end
    end, 50) -- espera 50ms antes de entrar no insert
  end,
})

-- Terminal toggleterm setup e execução de arquivos
local Terminal = require("toggleterm.terminal").Terminal
local term = nil

-- Função para buscar o diretório com arquivo .csproj (projeto C#)
local function find_csproj_dir(start_dir)
  local uv = vim.loop
  local dir = start_dir
  while dir do
    local handle = uv.fs_scandir(dir)
    if handle then
      while true do
        local name, _ = uv.fs_scandir_next(handle)
        if not name then break end
        if name:match("%.csproj$") then
          return dir
        end
      end
    end
    local parent_dir = vim.fn.fnamemodify(dir, ":h")
    if parent_dir == dir then break end
    dir = parent_dir
  end
  return nil
end

-- Função para pegar o DLL mais recente na pasta bin/Debug (C#)
local function get_latest_dll(project_dir)
  local base_dir = project_dir .. "/bin/Debug/"
  local dlls = vim.fn.glob(base_dir .. "**/*.dll", false, true)
  if #dlls == 0 then return nil end
  table.sort(dlls, function(a,b)
    local a_stat = vim.loop.fs_stat(a)
    local b_stat = vim.loop.fs_stat(b)
    if a_stat and b_stat then
      return a_stat.mtime.sec > b_stat.mtime.sec
    end
    return false
  end)
  return dlls[1]
end

-- Função para extrair o package declarado no arquivo Java
local function get_java_package(file_path)
  local file = io.open(file_path, "r")
  if not file then return nil end

  for _ = 1, 10 do -- lê até 10 linhas do arquivo (geralmente o package está no topo)
    local line = file:read("*l")
    if not line then break end
    local pkg = line:match("^%s*package%s+([%w%.]+)%s*;")
    if pkg then
      file:close()
      return pkg
    end
  end

  file:close()
  return nil
end

-- Função para rodar o arquivo atual com toggleterm (Python, C#, Java)
local function run_current_file_with_toggleterm()
  vim.cmd("write")

  local file_path = vim.fn.expand("%:p")
  local file_ext = vim.fn.expand("%:e")
  local file_dir = vim.fn.expand("%:p:h")
  local project_dir = find_csproj_dir(file_dir) or file_dir

  local cmd = nil

  if file_ext == "py" then
    cmd = "python3 '" .. file_path .. "'"

  elseif file_ext == "cs" then
    local build_cmd = "dotnet build '" .. project_dir .. "'"
    local dll_path = get_latest_dll(project_dir)
    if dll_path then
      cmd = build_cmd .. " && dotnet '" .. dll_path .. "'"
    else
      cmd = build_cmd .. " && dotnet run --project '" .. project_dir .. "'"
    end

  elseif file_ext == "java" then
    local file_name = vim.fn.expand("%:t:r")
    local java_pkg = get_java_package(file_path)

    -- Determina o diretório raiz do package para usar no classpath
    local java_root = file_dir
    if java_pkg then
      -- Conta quantos níveis ('.') no package para subir diretórios
      local dots = 0
      for _ in string.gmatch(java_pkg, '%.') do
        dots = dots + 1
      end
      -- Sobe (dots + 1) níveis
      for _ = 1, (dots + 1) do
        java_root = vim.fn.fnamemodify(java_root, ":h")
      end
    end

    local compile_cmd = "javac '" .. file_path .. "'"
    local exec_cmd
    if java_pkg then
      exec_cmd = "java -cp '" .. java_root .. "' " .. java_pkg .. "." .. file_name
    else
      exec_cmd = "java -cp '" .. java_root .. "' " .. file_name
    end

    cmd = compile_cmd .. " && " .. exec_cmd

  else
    vim.notify("Extensão '" .. file_ext .. "' não suportada para execução automática.", vim.log.levels.WARN)
    return
  end

  if term then
    term:close()
  end

  term = Terminal:new({
    cmd = cmd,
    direction = "horizontal",
    close_on_exit = false,
    on_open = function(t)
      vim.cmd("startinsert")
    end,
  })

  term:toggle()
end

-- Mapeia a tecla <F4> para executar o arquivo atual
vim.keymap.set("n", "<F4>", run_current_file_with_toggleterm, { noremap = true, silent = true })
