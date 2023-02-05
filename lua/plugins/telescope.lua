local Util = require "user.utils"

local M = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
        {
            "<C-p>",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "Git files",
        },
        {
            "<leader>p",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find files",
        },
        {
            "<leader>rf",
            function()
                require("telescope.builtin").oldfiles()
            end,
            desc = "Recent files",
        },
        {
            "<leader>ps",
            function()
                require("telescope.builtin").live_grep()
            end,
            { desc = "Live grep" },
        },
        {
            "<leader>pS",
            function()
                require("telescope.builtin").grep_string { search = vim.fn.input { prompt = "Grep > " } }
            end,
            desc = "Grep string",
        },
        {
            "<leader>pf",
            function()
                require("telescope.builtin").find_files {
                    find_command = { "fd", "package.json" },
                    -- previewer = {
                    --     title = " foo bar ba",
                    -- },
                }
            end,
            desc = "Package find",
        },

        { "<leader><space>", Util.telescope "buffers", desc = "Find existing buffers" },
        { "<leader>fh", Util.telescope "help_tags", desc = "Find help tags" },
    }, -- lazy loads on this pattern
}

M.config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    -- Just check laptop screen width for now
    -- TODO: Convert the column size to a more usable px width?
    -- local small_screen = vim.opt_global.columns:get() <= 140 -- Laptop screen is 137

    telescope.setup {

        mappings = {
            i = {},
            n = {
                ["<leader>bd"] = actions.delete_buffer,
            },
        },
        pickers = {
            find_files = {
                find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
            },
        },
    }
    require("telescope").load_extension "fzf"
end

return M
