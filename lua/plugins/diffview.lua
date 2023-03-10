return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
        { "<leader>gh", "<Cmd>DiffviewFileHistory<CR>", "Diff view history" },
        { "<leader>gH", "<Cmd>DiffviewFileHistory %<CR>", "Diff view file history" },
        { "<leader>gh", mode = "v", "<Esc><Cmd>'<,'>DiffviewFileHistory<CR>", desc = "Diff view range file history" },
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
    },
    config = function()
        require("diffview").setup {}
    end,
}
