local M = {}

-- menus por linguagem
local project_templates = {
  ["Python"] = { "Script simples", "Projeto com venv" },
  ["C#"] = { "Console App", "Estrutura básica" },
  ["Java"] = { "Main único", "Com pacote" },
}

-- lógica final de criação do projeto
local function handle_creation(language, template)
  local name = vim.fn.input("Nome do projeto (" .. language .. "): ")
  if name == nil or name == "" then
    print("Nome inválido.")
    return
  end

  local root = vim.fn.expand("~/Projects")
  local path = root .. "/" .. name

  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  else
    print("Projeto já existe!")
  end

  local main_file = nil

  if language == "Python" then
    if template == "Script simples" then
      main_file = "main.py"
      vim.fn.writefile({ 'print("Hello, Python!")' }, path .. "/" .. main_file)

    elseif template == "Projeto com venv" then
      main_file = "main.py"
      vim.fn.system({ "python3", "-m", "venv", path .. "/venv" })
      vim.fn.writefile({ 'print("Projeto com venv")' }, path .. "/" .. main_file)
    end

  elseif language == "C#" then
    if template == "Console App" then
      main_file = "Program.cs"
      vim.fn.writefile({
        'using System;',
        '',
        'class Program',
        '{',
        '    static void Main(string[] args)',
        '    {',
        '        Console.WriteLine("Hello, C#!");',
        '    }',
        '}',
      }, path .. "/" .. main_file)

    elseif template == "Estrutura básica" then
      main_file = "README.md"
      vim.fn.writefile({ '# Projeto C# básico' }, path .. "/" .. main_file)
    end

  elseif language == "Java" then
    if template == "Main único" then
      main_file = "Main.java"
      vim.fn.writefile({
        'public class Main {',
        '    public static void main(String[] args) {',
        '        System.out.println("Hello, Java!");',
        '    }',
        '}',
      }, path .. "/" .. main_file)

    elseif template == "Com pacote" then
      main_file = "src/Main.java"
      local pkg = path .. "/src"
      vim.fn.mkdir(pkg, "p")
      vim.fn.writefile({
        'package src;',
        '',
        'public class Main {',
        '    public static void main(String[] args) {',
        '        System.out.println("Hello from package!");',
        '    }',
        '}',
      }, pkg .. "/Main.java")
    end
  end

  vim.cmd("cd " .. path)

  if main_file then
    vim.cmd("edit " .. path .. "/" .. main_file)
  else
    vim.cmd("enew")
  end

  print("✅ Projeto " .. language .. " criado em " .. path)
end

-- menu principal
M.create_new_project = function()
  vim.ui.select(vim.tbl_keys(project_templates), {
    prompt = "Escolha a linguagem do projeto:",
  }, function(language)
    if not language then return end

    -- submenu de tipo de projeto
    vim.ui.select(project_templates[language], {
      prompt = "Escolha o tipo de projeto " .. language .. ":",
    }, function(template)
      if not template then return end
      handle_creation(language, template)
    end)
  end)
end

return M

