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

            -- load the colorscheme here
            vim.cmd [[colorscheme gruvbox-material]]
        end,
    },

    { "tpope/vim-fugitive", cmd = { "G" } },
    { "tpope/vim-surround" },
    { "norcalli/nvim-colorizer.lua" },
    { "windwp/nvim-autopairs", config = true }, -- See `config` under https://github.com/folke/lazy.nvim#-plugin-spec
    { "numToStr/Comment.nvim", config = true },
}
