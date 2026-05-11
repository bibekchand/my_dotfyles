local M = {}
local state = {
    buf = -1,
}
M.Window = function(prev_buf)
    local buf = nil
    if vim.api.nvim_buf_is_valid(prev_buf) then
        buf = prev_buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end
    local height = 20
    local width  = 60
    local row = math.floor((vim.o.lines - height) / 2 )
    local col = math.floor((vim.o.columns - width) /2 )
    local options = {
        style = "minimal",
        relative = "editor",
        row = row,
        col = col,
        width=width,
        height=height,
        bufpos={100,10}
    }
    vim.api.nvim_open_win(buf, true, options)
    return buf
end

local function legendary()
    state.buf = M.Window(state.buf)
    if vim.bo[state.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end
vim.keymap.set("n", "<leader>tm", legendary)
vim.keymap.set("t", "jk", "<c-\\><c-n>")
