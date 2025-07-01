return {
  {--tudo ok 
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- opcional, para ícones
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup()
    end,
  },
  
  
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      require('telescope').load_extension('projects')

    end,
  },
  
  {--aqui esta ok
    "soulis-1256/eagle.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("eagle").setup({})
    end,
  },
  {
  "iabdelkareem/csharp.nvim",
  dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  },
  config = function ()
      require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
      require("csharp").setup()
  end
  },
  {
  "neolooong/whichpy.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("whichpy").setup()
  end,
},

  {--tudo certo aqui tambem 
  "folke/twilight.nvim",
  config = function()
    require("twilight").setup({})
  end,
},
  
  {--tudo ok
  "shellRaining/hlchunk.nvim",
  config = function()
    require("hlchunk").setup({})
  end,
},
  {
  "Zeioth/compiler.nvim",
  dependencies = { "stevearc/overseer.nvim" },
  config = function()
    require("compiler").setup({})
  end,
},
  {
  "CRAG666/code_runner.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("code_runner").setup({})
  end,
},
{--tudo ok
  "dracula/vim",
  name = "dracula-official",
  config = function()
  vim.cmd("colorscheme dracula")
  end,
},
{--tudo ok
  "romgrk/barbar.nvim",
  dependencies = { "nvim-web-devicons", "nvim-lua/plenary.nvim" },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  config = function()
    require("barbar").setup({})
  end,
},

{--tudo ok por aqui
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup {
      size = 15,
      open_mapping = [[<C-\>]],
      shade_terminals = true,
      shading_factor = 2,
      direction = "horizontal", -- estilo VS Code
      start_in_insert = true,
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
    }
    local Terminal  = require("toggleterm.terminal").Terminal
  end,
},
{--tudo certo
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({})
  end,
},

{
  "stevearc/aerial.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("aerial").setup({})
  end,
},
{
  "folke/persistence.nvim",
  event = "BufReadPre", -- carrega antes de abrir buffer
  config = function()
    require("persistence").setup{
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- pasta das sessões
      options = { "buffers", "curdir", "tabpages", "winsize" },
    }
  end,
},
{
  "glepnir/dashboard-nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    local db = require('dashboard')

    db.setup({
      theme = 'doom',
      config = {
        header = {
'  ⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⡋⠉⠙⠒⢤⡀⠀⠀⠀⠀⠀⢠⠖⠉⠉⠙⠢⡄⠀',
'  ⠀⠀⠀⠀⠀⠀⢀⣼⣟⡒⠒⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀⢠⠃⠀⠀⠀⠀⠀⠹⡄',
'  ⠀⠀⠀⠀⠀⠀⣼⠷⠖⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⢷',
'  ⠀⠀⠀⠀⠀⠀⣷⡒⠀⠀⢐⣒⣒⡒⠀⣐⣒⣒⣧⠀⠀⡇⠀⢠⢤⢠⡠⠀⠀⢸',
'  ⠀⠀⠀⠀⠀⢰⣛⣟⣂⠀⠘⠤⠬⠃⠰⠑⠥⠊⣿⠀⢴⠃⠀⠘⠚⠘⠑⠐⠀⢸',
'  ⠀⠀⠀⠀⠀⢸⣿⡿⠤⠀⠀⠀⠀⠀⢀⡆⠀⠀⣿⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⣸',
'  ⠀⠀⠀⠀⠀⠈⠿⣯⡭⠀⠀⠀⠀⢀⣀⠀⠀⠀⡟⠀⠀⢸⠀⠀⠀⠀⠀⠀⢠⠏',
'  ⠀⠀⠀⠀⠀⠀⠀⠈⢯⡥⠄⠀⠀⠀⠀⠀⠀⡼⠁⠀⠀⠀⠳⢄⣀⣀⣀⡴⠃⠀',
'  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⡦⣄⣀⣀⣀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀',
'  ⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⠛⠃⠀⠀⠀⢹⠳⡶⣤⡤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀',
'  ⠀⠀⠀⠀⣠⢴⣿⣿⣿⡟⡷⢄⣀⣀⣀⡼⠳⡹⣿⣷⠞⣳⠀⠀⠀⠀⠀⠀⠀⠀',
'  ⠀⠀⠀⢰⡯⠭⠹⡟⠿⠧⠷⣄⣀⣟⠛⣦⠔⠋⠛⠛⠋⠙⡆⠀⠀⠀⠀⠀⠀⠀',
'  ⠀⠀⢸⣿⠭⠉⠀⢠⣤⠀⠀⠀⠘⡷⣵⢻⠀⠀⠀⠀⣼⠀⣇⠀⠀⠀⠀⠀⠀⠀',
'  ⠀⠀⡇⣿⠍⠁⠀⢸⣗⠂⠀⠀⠀⣧⣿⣼⠀⠀⠀⠀⣯⠀⢸⠀⠀⠀⠀⠀⠀⠀',
        },
        
        header_opts = { hl = "DashboardHeader" },   -- <- Adicione isto
    
    
    footer = {
      '',
      'Have a nice day!',
    },
    footer_opts = { hl = "DashboardFooter" },

        center = {
          {
            icon = ' ',
            desc = 'New File',
            action = 'enew',
            key = 'n',
            
          },
          {
  icon = " ",
  desc = "New Projects",
  key = "N",
  action = ":lua require('utils.projects').create_new_project()<CR>",
},

          


  -- <- Adicione isto

          {
  icon = ' ',
  desc = 'Projects',
  action = 'Telescope projects',
  key = 'p',
},

          {
            icon = ' ',
            desc = 'Find Text',
            action = 'Telescope live_grep',
            key = 'g',
          },
          {
            icon = ' ',
            desc = 'Recent Files',
            action = 'Telescope oldfiles',
            key = 'r',
          },
          {
            icon = ' ',
            desc = 'Config',
            action = 'Telescope find_files cwd=~/.config/nvim',
            key = 'c',
          },
  {
  icon = ' ',
  desc = 'Restore Session',
  key = 's',
  action = 'RestoreSession',
},

          {
            icon = ' ',
            desc = 'Lazy Extras',
            action = 'LazyExtras',
            key = 'x',
          },
          {
            icon = '󰒲 ',
            desc = 'Lazy',
            action = 'Lazy',
            key = 'l',
          },
          {
            icon = ' ',
            desc = 'Quit',
            action = 'qa',
            key = 'q',
          },
      },


      },
    }
    
)
vim.defer_fn(function()
  local namespace = vim.api.nvim_create_namespace("dashboard-fix")
  local icon_hl = "DashboardIcon"
  local desc_hl = "DashboardDesc"
  local key_hl = "DashboardKey"

  vim.api.nvim_set_hl(0, icon_hl, { fg = "#bd93f9", bold = true })
  vim.api.nvim_set_hl(0, desc_hl, { fg = "#f8f8f2" })
  vim.api.nvim_set_hl(0, key_hl, { fg = "#50fa7b", bold = true })

  local center_lines = {
    { icon = "", desc = "New File", key = "n" },
    { icon = "", desc = "New Projects", key = "N" },
    { icon = "", desc = "Projects", key = "p" },
    { icon = "", desc = "Find Text", key = "g" },
    { icon = "", desc = "Recent Files", key = "r" },
    { icon = "", desc = "Config", key = "c" },
    { icon = "", desc = "Restore Session", key = "s" },
    { icon = "", desc = "Lazy Extras", key = "x" },
    { icon = "󰒲", desc = "Lazy", key = "l" },
    { icon = "", desc = "Quit", key = "q" },
  }

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    for _, item in ipairs(center_lines) do
      if line:find(item.desc, 1, true) and line:find(item.icon, 1, true) then
        local icon_start = line:find(item.icon, 1, true) - 1
        local desc_start = line:find(item.desc, 1, true) - 1
        local key_start = line:find("%[" .. item.key .. "%]", 1, true)
        if icon_start and desc_start then
          vim.api.nvim_buf_add_highlight(0, namespace, icon_hl, i - 1, icon_start, icon_start + #item.icon)
          vim.api.nvim_buf_add_highlight(0, namespace, desc_hl, i - 1, desc_start, desc_start + #item.desc)
          if key_start then
            vim.api.nvim_buf_add_highlight(0, namespace, key_hl, i - 1, key_start, key_start + 3)
          end
        end
      end
    end
  end
end, 100)

  end,
  

  
},
{
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- configurações opcionais, pode deixar vazio por enquanto
    })
  end,
},
{
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}




}