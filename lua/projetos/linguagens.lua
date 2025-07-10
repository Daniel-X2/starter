local M = {}

-- Templates por linguagem
local project_templates = {
  ["Python"] = { "Script simples", "Projeto com venv" },
  ["C#"] = {
    "API Web do ASP.NET Core",
    "Aplicativo Autônomo Blazor WebAssembly",
    "Aplicativo do Console",
    "Aplicativo Web ASP.NET Core",
    "Aplicativo Web Blazor",
    "Aplicativo Web do ASP.NET Core (Model-View-Controller)",
    "Arquivo de Buffer de Protocolo",
    "Arquivo de Configuração da Web",
    "Arquivo de dotnet gitignore",
    "Arquivo de manifesto da ferramenta local Dotnet",
    "Arquivo de Solução",
    "Arquivo EditorConfig",
    "Arquivo global.json",
    "Arquivo MSBuild Directory.Build.props",
    "Arquivo MSBuild Directory.Build.targets",
    "Arquivo MSBuild Directory.Packages.props",
    "ASP.NET Core API Web (native AOT)",
    "ASP.NET Core Vazio",
    "Biblioteca de Classes",
    "Biblioteca de Classes Razor",
    "Classe de teste MSTest",
    "Componente Razor",
    "Configuração do NuGet",
    "Controlador de API",
    "Controlador MVC",
    "Exibição do Razor",
    "Item de Teste NUnit 3",
    "MVC ViewImports",
    "MVC ViewStart",
    "Projeto de Teste MSTest",
    "Projeto de Teste MSTest do Playwright",
    "Projeto de Teste NUnit 3",
    "Projeto de Teste NUnit do Playwright",
    "Projeto de Teste xUnit",
    "Página Razor",
    "Serviço de Trabalho",
    "Serviço gRPC do ASP.NET Core"
  },
  ["Java"] = {
    "Console Básico",
    "Aplicação com JUnit",
    "Web com Spring Boot",
    "Aplicação Gradle CLI",
  },
}

local base_path = vim.fn.expand("~/Área de trabalho/projetos")

local function file_exists(path)
  local f = io.open(path, "r")
  if f then f:close() return true else return false end
end

local function dir_exists(path)
  return vim.fn.isdirectory(path) == 1
end

local function run_cmd(cmd, cwd)
  local full_cmd = string.format("cd '%s' && %s", cwd, cmd)
  local result = vim.fn.system({"bash", "-c", full_cmd})
  local ret_code = vim.v.shell_error
  return ret_code, result
end

local function handle_creation(language, template)
  local project_name = vim.fn.input("Nome do projeto (" .. language .. "): ")
  if project_name == nil or project_name == "" then
    print("❌ Nome inválido.")
    return
  end

  local path = base_path .. "/" .. project_name

  -- Para Maven (Java), não criamos pasta antes, Maven cria
  if language ~= "Java" then
    if not dir_exists(path) then
      vim.fn.mkdir(path, "p")
    else
      print("⚠️ Projeto já existe, sobrescrevendo arquivos...")
    end
  else
    -- Para Java, se a pasta já existir, avisa e aborta
    if dir_exists(path) then
      print("❌ Projeto Java já existe! Apague a pasta para criar um novo.")
      return
    end
  end

  local main_file = nil
  local ret, output

  if language == "Python" then
    if template == "Script simples" then
      main_file = path .. "/main.py"
      vim.fn.writefile({ 'print("Olá, Neovim!")' }, main_file)

    elseif template == "Projeto com venv" then
      main_file = path .. "/main.py"
      ret, output = run_cmd("python3 -m venv .venv", path)
      if ret ~= 0 then
        print("❌ Erro criando venv: " .. output)
        return
      end
      vim.fn.writefile({ 'print("Projeto com venv")' }, main_file)
    end

  elseif language == "C#" then
    local dotnet_templates = {
      ["API Web do ASP.NET Core"] = "webapi",
      ["Aplicativo Autônomo Blazor WebAssembly"] = "blazorwasm",
      ["Aplicativo do Console"] = "console",
      ["Aplicativo Web ASP.NET Core"] = "webapp",
      ["Aplicativo Web Blazor"] = "blazor",
      ["Aplicativo Web do ASP.NET Core (Model-View-Controller)"] = "mvc",
      ["Arquivo de Buffer de Protocolo"] = "proto",
      ["Arquivo de Configuração da Web"] = "webconfig",
      ["Arquivo de dotnet gitignore"] = "gitignore",
      ["Arquivo de manifesto da ferramenta local Dotnet"] = "tool-manifest",
      ["Arquivo de Solução"] = "sln",
      ["Arquivo EditorConfig"] = "editorconfig",
      ["Arquivo global.json"] = "globaljson",
      ["Arquivo MSBuild Directory.Build.props"] = "buildprops",
      ["Arquivo MSBuild Directory.Build.targets"] = "buildtargets",
      ["Arquivo MSBuild Directory.Packages.props"] = "packagesprops",
      ["ASP.NET Core API Web (native AOT)"] = "webapiaot",
      ["ASP.NET Core Vazio"] = "web",
      ["Biblioteca de Classes"] = "classlib",
      ["Biblioteca de Classes Razor"] = "razorclasslib",
      ["Classe de teste MSTest"] = "mstest-class",
      ["Componente Razor"] = "razorcomponent",
      ["Configuração do NuGet"] = "nugetconfig",
      ["Controlador de API"] = "apicontroller",
      ["Controlador MVC"] = "mvccontroller",
      ["Exibição do Razor"] = "view",
      ["Item de Teste NUnit 3"] = "nunit-test",
      ["MVC ViewImports"] = "viewimports",
      ["MVC ViewStart"] = "viewstart",
      ["Projeto de Teste MSTest"] = "mstest",
      ["Projeto de Teste MSTest do Playwright"] = "mstest-playwright",
      ["Projeto de Teste NUnit 3"] = "nunit",
      ["Projeto de Teste NUnit do Playwright"] = "nunit-playwright",
      ["Projeto de Teste xUnit"] = "xunit",
      ["Página Razor"] = "page",
      ["Serviço de Trabalho"] = "worker",
      ["Serviço gRPC do ASP.NET Core"] = "grpc",
    }

    local template_name = dotnet_templates[template]
    if not template_name then
      print("❌ Template C# desconhecido: " .. tostring(template))
      return
    end

    ret, output = run_cmd("dotnet new " .. template_name .. " -o '" .. path .. "'", base_path)
    if ret ~= 0 then
      print("❌ Erro criando projeto dotnet: " .. output)
      return
    end

    main_file = path .. "/Program.cs"

  elseif language == "Java" then
    local cmd

    if template == "Console Básico" then
      cmd = table.concat({
        "mvn archetype:generate",
        "-DgroupId=" .. project_name,
        "-DartifactId=" .. project_name,
        "-Dpackage=" .. project_name,
        "-DarchetypeArtifactId=maven-archetype-quickstart",
        "-DinteractiveMode=false"
      }, " ")

      ret, output = run_cmd(cmd, base_path)
      if ret ~= 0 then
        print("❌ Erro criando projeto Maven: " .. output)
        return
      end

      local src_path = path .. "/src/main/java/" .. project_name
      local old_file = src_path .. "/App.java"
      local new_file = src_path .. "/Main.java"

      if file_exists(old_file) then
        os.rename(old_file, new_file)
        -- substitui "class App" por "class Main" no arquivo
        run_cmd("sed -i 's/class App/class Main/' '" .. new_file .. "'", src_path)
        main_file = new_file
      else
        print("⚠️ App.java não encontrado")
        main_file = nil
      end

    elseif template == "Aplicação com JUnit" then
      cmd = table.concat({
        "mvn archetype:generate",
        "-DgroupId=" .. project_name,
        "-DartifactId=" .. project_name,
        "-Dpackage=" .. project_name,
        "-DarchetypeArtifactId=maven-archetype-junit",
        "-DinteractiveMode=false"
      }, " ")

      ret, output = run_cmd(cmd, base_path)
      if ret ~= 0 then
        print("❌ Erro criando projeto Maven JUnit: " .. output)
        return
      end

      local src_path = path .. "/src/test/java/" .. project_name
      local old_file = src_path .. "/AppTest.java"
      local new_file = src_path .. "/MainTest.java"

      if file_exists(old_file) then
        os.rename(old_file, new_file)
        -- substitui "class AppTest" por "class MainTest" no arquivo
        run_cmd("sed -i 's/class AppTest/class MainTest/' '" .. new_file .. "'", src_path)
        main_file = new_file
      else
        print("⚠️ AppTest.java não encontrado")
        main_file = nil
      end

    elseif template == "Web com Spring Boot" then
      local zip_file = base_path .. "/" .. project_name .. ".zip"
      local curl_cmd = table.concat({
        "curl -s https://start.spring.io/starter.zip",
        "-d type=maven-project",
        "-d language=java",
        "-d name=" .. project_name,
        "-d groupId=com.spring",
        "-d artifactId=" .. project_name,
        "-d dependencies=web",
        "-o '" .. zip_file .. "'"
      }, " ")

      ret, output = run_cmd(curl_cmd, base_path)
      if ret ~= 0 then
        print("❌ Erro baixando Spring Boot: " .. output)
        return
      end

      local unzip_cmd = "unzip -o '" .. zip_file .. "' -d '" .. path .. "'"
      ret, output = run_cmd(unzip_cmd, base_path)
      if ret ~= 0 then
        print("❌ Erro descompactando Spring Boot: " .. output)
        return
      end

      main_file = path .. "/src/main/java/com/spring/Application.java"

    elseif template == "Aplicação Gradle CLI" then
      vim.fn.mkdir(path, "p")
      cmd = "gradle init --type java-application --project-name " .. project_name

      ret, output = run_cmd(cmd, path)
      if ret ~= 0 then
        print("❌ Erro criando projeto Gradle: " .. output)
        return
      end

      main_file = path .. "/src/main/java/App.java"

    else
      print("❌ Template Java desconhecido: " .. tostring(template))
      return
    end

  else
    print("❌ Linguagem não suportada: " .. tostring(language))
    return
  end

  if main_file and file_exists(main_file) then
    vim.cmd("edit " .. main_file)
  else
    print("⚠️ Arquivo principal não encontrado, abrindo novo buffer.")
    vim.cmd("enew")
  end

  print("✅ Projeto " .. language .. " criado em " .. path)
end

function M.create_new_project()
  vim.ui.select(vim.tbl_keys(project_templates), {
    prompt = "Escolha a linguagem do projeto:",
  }, function(language)
    if not language then return end

    vim.ui.select(project_templates[language], {
      prompt = "Escolha o tipo de projeto " .. language .. ":",
    }, function(template)
      if not template then return end
      handle_creation(language, template)
    end)
  end)
end

return M
