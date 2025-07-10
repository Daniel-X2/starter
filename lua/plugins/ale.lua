return{
  "dense-analysis/ale",
  event = "BufReadPre",  -- carrega ao abrir arquivo
  config = function()
    vim.g.ale_linters_explicit = 1  -- só roda linters configurados
    vim.g.ale_fix_on_save = 1       -- formata automaticamente ao salvar
    
    vim.g.ale_linters = {
      python = { "flake8", "mypy" },
      javascript = { "eslint" },
      sh = { "shellcheck" },
    }
    
    vim.g.ale_fixers = {
      python = { "black" },
      javascript = { "prettier" },
      sh = { "shfmt" },
    }
  end,
}
