vim.g.mapleader = " "
local opts = { silent = true, noremap = true }
vim.g.maplocalleader = " "
vim.keymap.set("i", "jk", "<Esc>", {})
vim.keymap.set("n", "<leader>wh", "<C-w>h", {})
vim.keymap.set("n", "<leader>wl", "<C-w>l", {})
vim.keymap.set("n", "<leader>wj", "<C-w>j", {})
vim.keymap.set("n", "<leader>wk", "<C-w>k", {})
vim.keymap.set("n", "<leader>wq", "<C-w>q", {})
vim.keymap.set("v", ">", ">gv", opts)
