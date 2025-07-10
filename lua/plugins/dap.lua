local function get_dll_path()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fs.dirname(current_file)

  local csproj_path = vim.fs.find(function(name)
    return name:match("%.csproj$")
  end, { upward = true, path = current_dir })[1]

  if not csproj_path then
    print("Arquivo .csproj não encontrado!")
    return ""
  end

  local project_dir = vim.fs.dirname(csproj_path)
  local project_name = vim.fn.fnamemodify(csproj_path, ":t:r")

  local dll_path = project_dir .. "/bin/Debug/net9.0/" .. project_name .. ".dll"

  if vim.fn.filereadable(dll_path) == 1 then
    return dll_path
  else
    print("DLL não encontrada em: " .. dll_path)
    return ""
  end
end





return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },
      {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
          require("persistent-breakpoints").setup {
            load_breakpoints_event = { "BufReadPost" }
          }
          vim.api.nvim_create_autocmd("BufReadPost", {
            callback = function()
              require("persistent-breakpoints.api").load_breakpoints()
            end,
          })
        end,
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Auto abrir/fechar o dap-ui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Adapter: Python (debugpy)
      dap.adapters.python = {
        type = 'executable',
        command = 'python',
        args = { '-m', 'debugpy.adapter' },
      }

      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = "${file}",
          pythonPath = function()
            return 'python'
          end,
        },
      }

      -- Adapter: C# (netcoredbg)
      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.expand("~/.local/share/netcoredbg/netcoredbg/netcoredbg"),
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch .NET",
          request = "launch",
          program = function()
            return get_dll_path()
          end,
        },
      }

      -- Adapter: Java
      dap.adapters.java = function(callback)
        callback({
          type = 'server',
          host = '127.0.0.1',
          port = 5005,
        })
      end

      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Attach to JVM",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        show_stop_reason = true,
        virt_text_pos = 'eol',
        highlight_changed_variables = true,
      })
    end,
  },
}