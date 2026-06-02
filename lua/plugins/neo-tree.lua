require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,

  window = {
    position = "right",   -- file tree on the RIGHT
    width = 35,
    mapping_options = { noremap = true, nowait = true },
    mappings = {
      ["<space>"] = { "toggle_node", nowait = false },
      ["<cr>"]    = "open",
      ["l"]       = "open",
      ["h"]       = "close_node",
      ["v"]       = "open_vsplit",
      ["s"]       = "open_split",
      ["t"]       = "open_tabnew",
      ["a"]       = { "add", config = { show_path = "relative" } },
      ["A"]       = "add_directory",
      ["d"]       = "delete",
      ["r"]       = "rename",
      ["c"]       = "copy",
      ["m"]       = "move",
      ["q"]       = "close_window",
      ["R"]       = "refresh",
      ["?"]       = "show_help",
    },
  },

  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = { ".git", "__pycache__", ".pytest_cache", ".mypy_cache" },
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
  },

  default_component_configs = {
    indent = {
      indent_size = 2,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
    },
    git_status = {
      symbols = {
        added     = "",
        modified  = "",
        deleted   = "✖",
        renamed   = "→",
        untracked = "★",
        ignored   = "◌",
        unstaged  = "✗",
        staged    = "✓",
        conflict  = "",
      },
    },
  },

  buffers = {
    follow_current_file = {
      enabled = true,
    },
  },
})
