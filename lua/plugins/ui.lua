return {

    -- floating winbar
    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        config = true,
    },

    -- auto-resize windows
    {
        "anuvyklack/windows.nvim",
        event = "WinNew",
        dependencies = {
            { "anuvyklack/middleclass" },
            { "anuvyklack/animation.nvim", enabled = false },
        },
        keys = { { "<C-w>z", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
        config = true,
    },
}
