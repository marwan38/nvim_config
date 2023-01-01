return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
        { "<leader>gh", "<Cmd>DiffviewFileHistory<CR>", "Diff view history" },
        { "<leader>gH", "<Cmd>DiffviewFileHistory %<CR>", "Diff view file history" },
        { "<leader>gh", "<Esc><Cmd>'<,'>DiffviewFileHistory<CR>", "Diff view range file history" },
    },
    config = function()
        require("diffview").setup {}
    end,
}
