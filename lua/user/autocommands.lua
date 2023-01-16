local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})
local user_group = augroup("UserGroup", {})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank {
            higroup = "IncSearch",
            timeout = 150,
        }
    end,
})

-- Project specific config
autocmd("VimEnter", {
    group = user_group,
    pattern = "*",
    callback = function()
        if vim.fn.filereadable ".vim/init.lua" == 1 then
            vim.cmd("source " .. ".vim/init.lua")
        end
    end,
})

-- Not sure what to map it to.. This is fine for now.
vim.api.nvim_create_user_command("TmuxSessionizer", function()
    vim.cmd "!tmux neww tmux-sessionizer"
end, {})

-- Sourced from https://github.com/sindrets/dotfiles/blob/master/.config/nvim/lua/user/lsp/init.lua
-- Only show diagnostics if current word + line is not the same as last call.
local last_diagnostics_word = nil
local function show_position_diagnostics()
    local cword = vim.fn.expand "<cword>"
    local cline = vim.api.nvim_win_get_cursor(0)[1]
    local bufnr = vim.api.nvim_get_current_buf()

    if
        last_diagnostics_word
        and last_diagnostics_word[1] == cline
        and last_diagnostics_word[2] == cword
        and last_diagnostics_word[3] == bufnr
    then
        return
    end
    last_diagnostics_word = { cline, cword, bufnr }

    vim.diagnostic.open_float { scope = "cursor", border = "single" }
end

-- Diagnostics on hover
vim.api.nvim_create_autocmd("CursorHold", {
    callback = show_position_diagnostics,
})
