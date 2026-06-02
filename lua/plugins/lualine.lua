local function get_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv then
    return " " .. vim.fn.fnamemodify(venv, ":t")
  end
  return ""
end

require("lualine").setup({
  options = {
    theme = "vscode",
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    disabled_filetypes   = { statusline = { "dashboard" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      get_venv,
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = { "neo-tree", "trouble", "quickfix" },
})
