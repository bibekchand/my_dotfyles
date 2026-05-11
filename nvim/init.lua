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
--vim.cmd("hi statusline guibg=NONE")

--plugins
vim.pack.add({
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/lervag/vimtex" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

-- loading the plugins
require("oil").setup()
require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
})
require("mason").setup()
require("mason-lspconfig").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("blink-cmp").setup({
    completion = { documentation = { auto_show = true } },
    fuzzy = { implementation = "lua" },
    keymap = { preset = "super-tab" },
})
vim.cmd("colorscheme rose-pine-main")
require("typst-preview").setup {}
require("mini.pick").setup()
--lsp stuff
vim.lsp.config['lua_ls'] = {
    -- Command and arguments to start the server.
    cmd = { 'lua-language-server' },
    -- Filetypes to automatically attach to.
    filetypes = { 'lua' },
    -- Sets the "workspace" to the directory where any of these files is found.
    -- Files that share a root directory will reuse the LSP server connection.
    -- Nested lists indicate equal priority, see |vim.lsp.Config|.
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    -- Specific settings to send to the server. The schema is server-defined.
    -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        }
    }
}
vim.lsp.enable({
    "ts_ls",
    "lua_ls",
    "clangd",
    "emmet_language_server",
    "tinymist",
    "pylsp",
    "tailwindcss",
    "biome",
    "sourcekit"
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
vim.keymap.set("n", "<leader>ls", ":<Plug>(live-server-start)", opts)
vim.keymap.set("n", "<leader>tw", ":TypstPreview <CR>", opts)
vim.keymap.set("n", "<leader>lg", ":LivePreview close<CR>", opts)
vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, opts)
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, opts)
vim.keymap.set("n", "<leader>ol", ":Oil<cr>", opts)
vim.keymap.set("n", "<leader>os", ":vsplit $MYVIMRC<CR>", opts)
vim.g.vimtex_view_method = "skim"
function _G.myfunc()
    local nepali_date = require("date_converter")
    return nepali_date.month .. " " .. nepali_date.day .. " " .. nepali_date.year
end

vim.o.statusline = "%f %y %= %{v:lua.myfunc()} [%l/%L]"
vim.cmd("hi StatusLine guifg=black guibg=DarkCyan")
require("floating_terminal")
