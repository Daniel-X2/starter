
local jdtls = require('jdtls')
local home = os.getenv("HOME")

-- Detecta o diretório do projeto
local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml'}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- Define workspace único por projeto
local workspace_dir = home .. '/.cache/jdtls/workspace/' .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Caminhos para o jdtls instalado via mason
local jdtls_path = home .. '/.local/share/nvim/mason/packages/jdtls'
local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local config_path = jdtls_path .. '/config_linux'

-- Configuração com idioma pt-BR
local config = {
  cmd = {
    'java',
    '-Duser.language=pt',
    '-Duser.country=BR',
    '-jar', launcher,
    '-configuration', config_path,
    '-data', workspace_dir,
  },
  root_dir = root_dir,
}

jdtls.start_or_attach(config)
