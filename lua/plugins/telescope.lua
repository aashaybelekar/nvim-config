local telescope = require("telescope")
local actions   = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix   = " ",
    selection_caret = " ",
    path_display    = { "smart" },
    file_ignore_patterns = {
      "%.git/", "__pycache__/", "%.pyc", "node_modules/",
      "%.egg%-info/", "%.venv/", "venv/", ".venv/",
    },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<Esc>"] = actions.close,
      },
    },
    layout_config = {
      horizontal = { preview_width = 0.55 },
      vertical   = { mirror = false },
      width      = 0.87,
      height     = 0.80,
    },
    sorting_strategy = "ascending",
    layout_strategy  = "horizontal",
  },
  pickers = {
    find_files = { hidden = true },
  },
  extensions = {
    fzf = {
      fuzzy                   = true,
      override_generic_sorter = true,
      override_file_sorter    = true,
      case_mode               = "smart_case",
    },
  },
})

telescope.load_extension("fzf")
