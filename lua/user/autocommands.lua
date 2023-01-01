local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})

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

-- Not sure what to map it to.. This is fine for now.
vim.api.nvim_create_user_command("TmuxSessionizer", function()
    vim.cmd "!tmux neww tmux-sessionizer"
end, {})
