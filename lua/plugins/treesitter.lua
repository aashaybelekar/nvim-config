return {
  ensure_installed = {
    "python", "go", "gomod", "gowork", "gotmpl",
    "lua", "vim", "vimdoc", "query",
    "json", "yaml", "toml", "markdown", "markdown_inline",
    "bash", "regex", "html", "css", "javascript", "typescript",
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "<C-space>",
      node_incremental  = "<C-space>",
      scope_incremental = "<C-s>",
      node_decremental  = "<bs>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start      = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end        = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
      goto_previous_start  = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
      goto_previous_end    = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    },
  },
}
