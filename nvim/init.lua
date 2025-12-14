---@diagnostic disable: undefined-global
local opts = { silent = true, noremap = true }
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>wh", "<C-w>h", opts)
vim.keymap.set("n", "<leader>wl", "<C-w>l", opts)
vim.keymap.set("n", "<leader>wj", "<C-w>j", opts)
vim.keymap.set("n", "<leader>wk", "<C-w>k", opts)
vim.keymap.set("n", "<leader>wq", "<C-w>q", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("i", "jk", "<Esc>", opts)

-- options
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
--make hover rounded
vim.o.winborder = "rounded"
--remove the status line
vim.cmd("hi statusline guibg=NONE")

--plugins
vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/kaarmu/typst.vim" },
	{ src = "https://github.com/brianhuster/live-preview.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

-- loading the plugins
require("mason").setup()
require("mason-lspconfig").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("blink-cmp").setup({
	completion = { documentation = { auto_show = true } },
	fuzzy = { implementation = "lua" },
	keymap = { preset = "super-tab" },
})
vim.cmd("colorscheme rose-pine-main")
require("livepreview.config").set()
require("mini.pick").setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "lua", "c", "html", "cpp", "css" },
	highlight = { enable = true },
	indent = { enable = true },
})
--lsp stuff
vim.lsp.enable({
	"lua_ls",
	"clangd",
	"tinymist",
	"biome",
	"emmet_language_server",
	"ts_ls",
	"asm_lsp",
	"tailwindcss",
	"pylsp",
	"stylua",
})
vim.lsp.config["tinymist"] = {
	settings = { formatterMode = "typstyle" },
}

-- Remap
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

--Enable inline diagnostics
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})

--make background same as terminal
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])

--some shortcuts
vim.keymap.set("n", "<leader>tw", ":TypstWatch <CR>", opts)
vim.keymap.set("n", "<leader>ls", ":LivePreview start<CR>", opts)
vim.keymap.set("n", "<leader>lg", ":LivePreview close<CR>", opts)
vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, opts)
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, opts)
