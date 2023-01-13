return {
    {
        "sainnhe/gruvbox-material",
        enabled = false,
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.g.gruvbox_material_background = "medium"
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_diagnostic_line_highlight = 1
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        build = ':lua require("nightfox").compile()',
        config = function()
            require("nightfox").setup {
                options = {
                    transparent = false, -- Disable setting background
                    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*)
                    dim_inactive = false, -- Non focused panes set to alternative background
                    styles = { -- Style to be applied to different syntax groups
                        comments = "italic",
                        conditionals = "NONE",
                        constants = "NONE",
                        functions = "bold",
                        keywords = "bold",
                        numbers = "NONE",
                        operators = "NONE",
                        strings = "italic",
                        types = "NONE",
                        variables = "NONE",
                    },
                    inverse = {
                        match_paren = false,
                        visual = false,
                        search = false,
                    },
                },
            }
            vim.cmd "colorscheme duskfox"
        end,
    },
}
