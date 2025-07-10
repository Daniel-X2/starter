-- Sempre mostra a coluna de sinais (ícones)

-- Configura diagnóstico com ícones inline
vim.diagnostic.config({
  virtual_text = {
    prefix = function(diagnostic)
      local icons = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "󰌵",
        [vim.diagnostic.severity.INFO] = "",
      }
      return icons[diagnostic.severity] .. " "
    end,
  },
  signs = true,
  underline = true,
  update_in_insert =true,
  severity_sort = true,
})


vim.diagnostic.config({
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = "", texthl = "DiagnosticError" },
      { name = "DiagnosticSignWarn", text = "", texthl = "DiagnosticWarn" },
      { name = "DiagnosticSignInfo", text = "", texthl = "DiagnosticInfo" },
      { name = "DiagnosticSignHint", text = "", texthl = "DiagnosticHint" },
    },
  },
})
local dap_signs = {
  { name = "DapBreakpoint", text = "", texthl = "Error" },
  { name = "DapStopped", text = "", texthl = "Success" },
  { name = "DapBreakpointRejected", text = "", texthl = "WarningMsg" },
}

for _, sign in ipairs(dap_signs) do
  vim.fn.sign_define(sign.name, {
    text = sign.text,
    texthl = sign.texthl,
    linehl = "",
    numhl = "",
  })
end

