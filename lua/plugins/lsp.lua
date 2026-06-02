require("mason").setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed   = "✓",
      package_pending     = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",  -- Python
    "ruff",     -- Python linting (replaces ruff_lsp)
    "gopls",    -- Go
    "lua_ls",   -- Lua
    "jsonls",   -- JSON
    "yamlls",   -- YAML
    "bashls",   -- Bash
  },
  automatic_installation = true,
})

-- ── Capabilities ──────────────────────────────────────────────────────────────
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Apply capabilities to all servers globally
vim.lsp.config("*", { capabilities = capabilities })

-- ── Diagnostic signs & display ────────────────────────────────────────────────
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text  = { prefix = "●", source = "if_many" },
  float         = { border = "rounded", source = "always" },
  signs         = true,
  underline     = true,
  update_in_insert = false,
  severity_sort = true,
})

-- ── Hover / signature borders (replaces deprecated vim.lsp.with) ──────────────
vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  vim.lsp.handlers.hover(err, result, ctx,
    vim.tbl_extend("force", config or {}, { border = "rounded" }))
end
vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
  vim.lsp.handlers.signature_help(err, result, ctx,
    vim.tbl_extend("force", config or {}, { border = "rounded" }))
end

-- ── Keymaps on attach (LspAttach replaces on_attach) ─────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "gd",         vim.lsp.buf.definition,      "Go to definition")
    map("n", "gD",         vim.lsp.buf.declaration,     "Go to declaration")
    map("n", "gr",         vim.lsp.buf.references,      "References")
    map("n", "gi",         vim.lsp.buf.implementation,  "Implementation")
    map("n", "gt",         vim.lsp.buf.type_definition, "Type definition")
    map("n", "gh",         vim.lsp.buf.hover,           "Hover docs")
    map("n", "<C-k>",      vim.lsp.buf.signature_help,  "Signature help")
    map("n", "<leader>rn", vim.lsp.buf.rename,          "Rename")
    map("n", "<leader>ca", vim.lsp.buf.code_action,     "Code action")
    map("n", "[d",         vim.diagnostic.goto_prev,    "Prev diagnostic")
    map("n", "]d",         vim.diagnostic.goto_next,    "Next diagnostic")
    map("n", "<leader>d",  vim.diagnostic.open_float,   "Show diagnostic")

    -- Disable hover for ruff (pyright handles it)
    if client and client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
})

-- ── Server configs ─────────────────────────────────────────────────────────────

vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode       = "basic",
        autoSearchPaths        = true,
        useLibraryCodeForTypes = true,
        diagnosticMode         = "workspace",
        autoImportCompletions  = true,
      },
    },
  },
})

vim.lsp.config("ruff", {
  init_options = {
    settings = { args = {} },
  },
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses        = { unusedparams = true, shadow = true },
      staticcheck     = true,
      gofumpt         = true,
      usePlaceholders = true,
      hints = {
        assignVariableTypes    = true,
        compositeLiteralFields = true,
        functionTypeParameters = true,
        parameterNames         = true,
        rangeVariableTypes     = true,
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace   = { checkThirdParty = false },
      telemetry   = { enable = false },
    },
  },
})

-- ── Enable all servers ────────────────────────────────────────────────────────
vim.lsp.enable({ "pyright", "ruff", "gopls", "lua_ls", "jsonls", "yamlls", "bashls" })
