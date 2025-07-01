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
          'Welcome to Neovim',
          '',
        },
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
  action = function()
    require("utils.projects").create_new_project()
  end,
},


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
        footer = {
          '',
          'Have a nice day!',
        },
      },
    })
  end,
},
{
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- configurações opcionais, pode deixar vazio por enquanto
    })
  end,
}




}