local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── Insert mode ────────────────────────────────────────────────────────────
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "<D-c>", "<Esc>", { desc = "Cmd+C exits insert mode" })

-- ── Navigation: J/K jump 5 lines ───────────────────────────────────────────
map({ "n", "v" }, "J", "5j", { desc = "Jump 5 lines down" })
map({ "n", "v" }, "K", "5k", { desc = "Jump 5 lines up" })

-- Keep J/K for joining lines and LSP hover via explicit leader or lsp map
-- (original J = join line is remapped below as <leader>j)
map("n", "<leader>J", "J", { desc = "Join lines" })

-- ── Window navigation ────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- ── Buffer navigation ─────────────────────────────────────────────────────
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })

-- ── File explorer ─────────────────────────────────────────────────────────
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus file explorer" })

-- ── Telescope (fuzzy find) ────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files (Ctrl+P)" })

-- ── LSP (set in lsp.lua on_attach, but globals here) ─────────────────────
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gh", vim.lsp.buf.hover, { desc = "Hover docs" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- ── Formatting ────────────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file/range" })

-- ── Indentation in visual mode ────────────────────────────────────────────
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- ── Move lines ────────────────────────────────────────────────────────────
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── Misc ──────────────────────────────────────────────────────────────────
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<C-s>", ":w<CR>", { desc = "Save (Ctrl+S)" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save (Ctrl+S) insert" })

-- ── Terminal ──────────────────────────────────────────────────────────────
map("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ── Python run ───────────────────────────────────────────────────────────
map("n", "<leader>rp", ":w<CR>:!python3 %<CR>", { desc = "Run Python file" })
