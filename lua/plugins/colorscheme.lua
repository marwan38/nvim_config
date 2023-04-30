return {
    {
        "sainnhe/everforest",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.everforest_enable_italic = 1
            vim.g.everforest_background = "medium"
            vim.cmd "colorscheme everforest"
        end,
    },
    {
        "sainnhe/gruvbox-material",
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_diagnostic_line_highlight = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
            vim.g.gruvbox_material_enable_italic = 1
            vim.cmd "colorscheme gruvbox-material"
        end,
    },
}
