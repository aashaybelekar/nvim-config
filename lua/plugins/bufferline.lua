require("bufferline").setup({
  options = {
    mode            = "buffers",
    numbers         = "none",
    close_command   = "bdelete! %d",
    indicator       = { icon = "▎", style = "icon" },
    buffer_close_icon = "󰅖",
    modified_icon     = "●",
    close_icon        = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
    offsets = {
      {
        filetype   = "neo-tree",
        text       = "File Explorer",
        highlight  = "Directory",
        text_align = "center",
        separator  = true,
      },
    },
    show_buffer_icons         = true,
    show_buffer_close_icons   = true,
    show_close_icon           = false,
    show_tab_indicators       = true,
    separator_style           = "slant",
    always_show_bufferline    = true,
  },
})
