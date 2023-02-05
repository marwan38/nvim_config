local api = vim.api

local M = {}


---Delete a buffer while also preserving the window layout. Changes the current
---buffer to the alt buffer if available, and then deletes it.
---@param force? boolean Ignore unsaved changes.
---@param bufnr? integer
function M.remove_buffer(force, bufnr)
    local utils = require('user.utils')
    force = force or false

    local new_bufnr
    local cur_bufnr = api.nvim_get_current_buf()
    bufnr = bufnr or cur_bufnr

    if not api.nvim_buf_is_valid(bufnr) then
        return
    end

    if not force then
        local modified = vim.bo[bufnr].modified
        if modified then
            utils.err "No write since last change!"
            return
        end
    end

    -- Get all windows that currently display the target
    local wins = vim.tbl_filter(function(v)
        return api.nvim_win_get_buf(v) == bufnr
    end, api.nvim_list_wins()) --[[@as vector ]]

    if #wins == 0 then
        new_bufnr = api.nvim_get_current_buf()

        if new_bufnr == bufnr then
            new_bufnr = api.nvim_create_buf(true, false)
        end
    else
        local alt_win

        if api.nvim_get_current_buf() == bufnr then
            alt_win = api.nvim_get_current_win()
        else
            alt_win = wins[1]
        end

        api.nvim_win_call(alt_win, function()
            -- bufnr("#") only works correctly when called from the current buffer.
            local alt_bufnr = bufnr == cur_bufnr and vim.fn.bufnr "#" or -1

            if alt_bufnr ~= -1 then
                api.nvim_set_current_buf(alt_bufnr)
            else
                local listed = utils.list_bufs { listed = true }
                if #listed > (vim.bo[bufnr].buflisted and 1 or 0) then
                    vim.cmd "silent! bp"
                else
                    vim.cmd "enew"
                end
            end

            new_bufnr = api.nvim_get_current_buf()
        end)
    end

    -- Change the buffer in all windows that currently display the target
    -- buffer.
    for _, winid in ipairs(wins) do
        api.nvim_win_set_buf(winid, new_bufnr)
    end

    if api.nvim_buf_is_valid(bufnr) then
        api.nvim_buf_delete(bufnr, { force = true })
    end
end

return M
