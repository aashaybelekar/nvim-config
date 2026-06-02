require("conform").setup({
  formatters_by_ft = {
    python     = { "ruff_format", "ruff_organize_imports" },
    lua        = { "stylua" },
    json       = { "prettierd", "prettier" },
    yaml       = { "prettierd", "prettier" },
    markdown   = { "prettierd", "prettier" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    go         = { "goimports", "gofmt" },
    sh         = { "shfmt" },
  },
  format_on_save = {
    timeout_ms = 3000,
    lsp_fallback = true,
  },
  formatters = {},
})
