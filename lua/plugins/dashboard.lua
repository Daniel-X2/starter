return {
{
    "glepnir/dashboard-nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      local db = require("dashboard")

      db.setup({
        theme = "doom",
        config = {
          header = {
            "  ⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⡋⠉⠙⠒⢤⡀⠀⠀⠀⠀⠀⢠⠖⠉⠉⠙⠢⡄⠀",
            "  ⠀⠀⠀⠀⠀⠀⢀⣼⣟⡒⠒⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀⢠⠃⠀⠀⠀⠀⠀⠹⡄",
            "  ⠀⠀⠀⠀⠀⠀⣼⠷⠖⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⢷",
            "  ⠀⠀⠀⠀⠀⠀⣷⡒⠀⠀⢐⣒⣒⡒⠀⣐⣒⣒⣧⠀⠀⡇⠀⢠⢤⢠⡠⠀⠀⢸",
            "  ⠀⠀⠀⠀⠀⢰⣛⣟⣂⠀⠘⠤⠬⠃⠰⠑⠥⠊⣿⠀⢴⠃⠀⠘⠚⠘⠑⠐⠀⢸",
            "  ⠀⠀⠀⠀⠀⢸⣿⡿⠤⠀⠀⠀⠀⠀⢀⡆⠀⠀⣿⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⣸",
            "  ⠀⠀⠀⠀⠀⠈⠿⣯⡭⠀⠀⠀⠀⢀⣀⠀⠀⠀⡟⠀⠀⢸⠀⠀⠀⠀⠀⠀⢠⠏",
            "  ⠀⠀⠀⠀⠀⠀⠀⠈⢯⡥⠄⠀⠀⠀⠀⠀⠀⡼⠁⠀⠀⠀⠳⢄⣀⣀⣀⡴⠃⠀",
            "  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⡦⣄⣀⣀⣀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀",
            "  ⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⠛⠃⠀⠀⠀⢹⠳⡶⣤⡤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "  ⠀⠀⠀⠀⣠⢴⣿⣿⣿⡟⡷⢄⣀⣀⣀⡼⠳⡹⣿⣷⠞⣳⠀⠀⠀⠀⠀⠀⠀⠀",
            "  ⠀⠀⠀⢰⡯⠭⠹⡟⠿⠧⠷⣄⣀⣟⠛⣦⠔⠋⠛⠛⠋⠙⡆⠀⠀⠀⠀⠀⠀⠀",
            "  ⠀⠀⢸⣿⠭⠉⠀⢠⣤⠀⠀⠀⠘⡷⣵⢻⠀⠀⠀⠀⣼⠀⣇⠀⠀⠀⠀⠀⠀⠀",
            "  ⠀⠀⡇⣿⠍⠁⠀⢸⣗⠂⠀⠀⠀⣧⣿⣼⠀⠀⠀⠀⣯⠀⢸⠀⠀⠀⠀⠀⠀⠀",
          },

          header_opts = { hl = "DashboardHeader" }, -- <- Adicione isto

          footer = {
            "",
            "Have a nice day!",
          },
          footer_opts = { hl = "DashboardFooter" },

          center = {
            {
              icon = " ",
              desc = "New File",
              action = "enew",
              key = "n",
            },
            {
              icon = " ",
              desc = "New Projects",
              key = "N",
              action = function()
    require("projetos.linguagens").create_new_project()
  end,
            },

            -- <- Adicione isto

            {
              icon = " ",
              desc = "Projects",
              action = function()
    require("projetos.project")()
  end,
            },

            {
              icon = " ",
              desc = "Find Text",
              action = "Telescope live_grep",
              key = "g",
            },
            {
              icon = " ",
              desc = "Recent Files",
              action = "Telescope oldfiles",
              key = "r",
            },
            {
              icon = " ",
              desc = "Config",
              action = "Telescope find_files cwd=~/.config/nvim",
              key = "c",
            },
            {
              icon = " ",
              desc = "Restore Session",
              key = "s",
              action = "RestoreSession",
            },

            {
              icon = " ",
              desc = "Lazy Extras",
              action = "LazyExtras",
              key = "x",
            },
            {
              icon = "󰒲 ",
              desc = "Lazy",
              action = "Lazy",
              key = "l",
            },
            {
              icon = " ",
              desc = "Quit",
              action = "qa",
              key = "q",
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
      end,100)
    end,
  },
}
