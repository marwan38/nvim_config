local M = {
    "tamago324/lir.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    keys = {
        {
            "<leader>ee",
            function()
                require("lir.float").toggle(vim.fn.expand "%:p:h")
            end,
            { desc = "Lir toggle" },
        },
        {
            "<leader>E",
            function()
                require("lir.float").toggle(vim.fn.getcwd())
            end,
            { desc = "Lir toggle in cwd" },
        },
    },
}

M.config = function()
    local actions = require "lir.actions"
    local mark_actions = require "lir.mark.actions"
    local clipboard_actions = require "lir.clipboard.actions"

    local lir = require "lir"

    lir.setup {
        show_hidden_files = true,
        ignore = {}, -- { ".DS_Store" "node_modules" } etc.
        devicons = {
            enable = true,
            highlight_dirname = false,
        },

        mappings = {
            ["l"] = actions.edit,
            ["<CR>"] = actions.edit,
            ["<C-s>"] = actions.split,
            ["<C-v>"] = actions.vsplit,
            ["<C-t>"] = actions.tabedit,
            ["<C-Q>"] = function()
                local ctx = lir.get_context()
                local path_list = vim.tbl_map(function(items)
                    return { filename = string.gsub(items.fullpath, "//", "/"), lnum = 1, col = 1 }
                end, ctx.files)

                vim.fn.setqflist(path_list, "r")
            end,

            ["h"] = actions.up,
            ["q"] = actions.quit,

            ["D"] = actions.mkdir,
            ["N"] = actions.newfile,
            ["r"] = actions.rename,
            ["@"] = actions.cd,
            ["y"] = clipboard_actions.copy,
            ["gy"] = actions.yank_path,
            ["."] = actions.toggle_show_hidden,
            ["d"] = actions.delete,

            ["t"] = mark_actions.toggle_mark,
            ["J"] = function()
                mark_actions.toggle_mark {}
                vim.cmd "normal! j"
            end,
            ["c"] = clipboard_actions.copy,
            ["x"] = clipboard_actions.cut,
            ["p"] = clipboard_actions.paste,
        },
        float = {
            winblend = 5,
            curdir_window = {
                enable = false,
                highlight_dirname = true,
            },

            -- -- You can define a function that returns a table to be passed as the third
            -- -- argument of nvim_open_win().
            -- win_opts = function()
            --   local width = math.floor(vim.o.columns * 0.8)
            --   local height = math.floor(vim.o.lines * 0.8)
            --   return {
            --     border = {
            --       "+", "─", "+", "│", "+", "─", "+", "│",
            --     },
            --     width = width,
            --     height = height,
            --     row = 1,
            --     col = math.floor((vim.o.columns - width) / 2),
            --   }
            -- end,
        },
        hide_cursor = true,
        on_init = function()
            -- use visual mode
            vim.api.nvim_buf_set_keymap(
                0,
                "x",
                "J",
                ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
                { noremap = true, silent = true }
            )

            -- echo cwd
            vim.api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
        end,
    }
end

return M
