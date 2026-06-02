-- Install parsers (no-op if already installed)
require("nvim-treesitter").install({
	"python",
	"go",
	"gomod",
	"gowork",
	"gotmpl",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"json",
	"yaml",
	"toml",
	"markdown",
	"markdown_inline",
	"bash",
	"regex",
	"html",
	"css",
	"javascript",
	"typescript",
})

-- Enable highlighting and indentation for all filetypes
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start)
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Textobjects: select
require("nvim-treesitter-textobjects").setup({
	select = { lookahead = true },
})

local ts_select = require("nvim-treesitter-textobjects.select")
local select_maps = {
	["af"] = "@function.outer",
	["if"] = "@function.inner",
	["ac"] = "@class.outer",
	["ic"] = "@class.inner",
	["aa"] = "@parameter.outer",
	["ia"] = "@parameter.inner",
}
for lhs, query in pairs(select_maps) do
	vim.keymap.set({ "x", "o" }, lhs, function()
		ts_select.select_textobject(query, "textobjects")
	end)
end

-- Compatibility shim: restore ft_to_lang for telescope and other plugins using old API
local ok, parsers = pcall(require, "nvim-treesitter.parsers")
if ok and not parsers.ft_to_lang then
  parsers.ft_to_lang = function(ft)
    return vim.treesitter.language.get_lang(ft) or ft
  end
end

-- Textobjects: move
local ts_move = require("nvim-treesitter-textobjects.move")
vim.keymap.set("n", "]f", function()
	ts_move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function" })
vim.keymap.set("n", "]c", function()
	ts_move.goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class" })
vim.keymap.set("n", "]F", function()
	ts_move.goto_next_end("@function.outer", "textobjects")
end, { desc = "Next function end" })
vim.keymap.set("n", "]C", function()
	ts_move.goto_next_end("@class.outer", "textobjects")
end, { desc = "Next class end" })
vim.keymap.set("n", "[f", function()
	ts_move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Prev function" })
vim.keymap.set("n", "[c", function()
	ts_move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "Prev class" })
vim.keymap.set("n", "[F", function()
	ts_move.goto_previous_end("@function.outer", "textobjects")
end, { desc = "Prev function end" })
vim.keymap.set("n", "[C", function()
	ts_move.goto_previous_end("@class.outer", "textobjects")
end, { desc = "Prev class end" })
