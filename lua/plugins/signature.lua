return {
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        floating_window = true,
  fix_pos = true,
  hint_enable = false,   -- desativa a dica inline que pode causar duplicação visual
  handler_opts = {
    border = "rounded"
        }
      })
    end,
  },
}