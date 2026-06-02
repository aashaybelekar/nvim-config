require("dashboard").setup({
  theme = "hyper",
  config = {
    week_header = { enable = true },
    shortcut = {
      { desc = "󰊳 Update",    group = "@property",   action = "Lazy update",            key = "u" },
      { desc = " Files",     group = "Label",        action = "Telescope find_files",   key = "f" },
      { desc = " Recent",    group = "Label",        action = "Telescope oldfiles",     key = "r" },
      { desc = " Grep",      group = "Label",        action = "Telescope live_grep",    key = "g" },
      { desc = " Config",    group = "Number",       action = "e ~/.config/nvim/init.lua", key = "c" },
      { desc = " Quit",      group = "DiagnosticError", action = "qa",                 key = "q" },
    },
  },
})
