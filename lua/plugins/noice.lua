return {
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  config = function()
    require("noice").setup({
      lsp = {
        progress = { enabled = true },
        signature = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 40,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 40,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
        confirm = {
          size = {
            width = 40,
            height = "auto",
          },
          border = {
            style = "rounded",
          },
        },
        hover = {
          size = {
            width = 60,
            height = 10,
          },
        },
        mini = {
          size = {
            width = 40,
            height = "auto",
          },
        },
        notify = {
          size = {
            width = 50,
            height = 6,
          },
        },
        split = {
          size = {
            height = 8,
          },
        },
      },
    })
    require("notify").setup({
  stages = "fade_in_slide_out",
  timeout = 2000,
  max_width = 50,
  max_height = 5,
})

  end,
}

