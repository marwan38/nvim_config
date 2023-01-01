local M = {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
    cmd = { "Telescope", "Tel" }, -- lazy loads on these commands
    keys = { "<leader>p", "<C-p>" }, -- lazy loads on this pattern
}

M.config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    -- Just check laptop screen width for now
    -- TODO: Convert the column size to a more usable px width?
    local small_screen = vim.opt_global.columns:get() <= 140 -- Laptop screen is 137

    telescope.setup {
        mappings = {
            i = {
                ["<C-w>"] = actions.delete_buffer,
            },
            n = {},
        },
    }

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
    vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>rf", builtin.oldfiles, { desc = "Recent files" })
    vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find existing buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
end

return M
