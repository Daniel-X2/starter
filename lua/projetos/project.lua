local has_telescope, telescope = pcall(require, "telescope.builtin")
if not has_telescope then
  vim.notify("Telescope não está instalado", vim.log.levels.ERROR)
  return
end

local pastas_principais = {
  "/home/daniel/Área de trabalho/projetos",
  "/home/daniel",
}

local function listar_subpastas(base_path)
  local handle = io.popen('find "' .. base_path .. '" -mindepth 1 -maxdepth 1 -type d 2>/dev/null')
  local pastas = {}
  if handle then
    for line in handle:lines() do
      table.insert(pastas, line)
    end
    handle:close()
  end
  return pastas
end

local function escolher_pasta_principal(callback)
  vim.ui.select(pastas_principais, {
    prompt = "Escolha a pasta principal:",
    format_item = function(item)
      return vim.fn.fnamemodify(item, ":t")
    end,
  }, function(choice)
    if choice then
      callback(choice)
    else
      vim.notify("Nenhuma pasta principal selecionada", vim.log.levels.INFO)
    end
  end)
end

local function escolher_subpasta(base_path)
  local subpastas = listar_subpastas(base_path)
  if #subpastas == 0 then
    vim.notify("Nenhuma subpasta encontrada em " .. base_path, vim.log.levels.WARN)
    return
  end

  vim.ui.select(subpastas, {
    prompt = "Escolha o projeto:",
    format_item = function(item)
      return vim.fn.fnamemodify(item, ":t")
    end,
  }, function(choice)
    if choice then
      telescope.find_files({ cwd = choice })
    else
      vim.notify("Nenhum projeto selecionado", vim.log.levels.INFO)
    end
  end)
end

local function projetos()
  escolher_pasta_principal(function(base_path)
    escolher_subpasta(base_path)
  end)
end

return projetos




