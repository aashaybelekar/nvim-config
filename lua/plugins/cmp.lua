local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion    = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
    format = lspkind.cmp_format({
      mode   = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
      symbol_map = {
        Text          = "󰉿",
        Method        = "󰆧",
        Function      = "󰊕",
        Constructor   = "",
        Field         = "󰜢",
        Variable      = "󰀫",
        Class         = "󰠱",
        Interface     = "",
        Module        = "",
        Property      = "󰜢",
        Unit          = "󰑭",
        Value         = "󰎠",
        Enum          = "",
        Keyword       = "󰌋",
        Snippet       = "",
        Color         = "󰏘",
        File          = "󰈙",
        Reference     = "󰈇",
        Folder        = "󰉋",
        EnumMember    = "",
        Constant      = "󰏿",
        Struct        = "󰙅",
        Event         = "",
        Operator      = "󰆕",
        TypeParameter = "",
      },
    }),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip",  priority = 750 },
    { name = "buffer",   priority = 500 },
    { name = "path",     priority = 250 },
  }),

  experimental = {
    ghost_text = { hl_group = "CmpGhostText" },
  },
})

-- Cmdline completion
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = "path" } },
    { { name = "cmdline" } }
  ),
})
