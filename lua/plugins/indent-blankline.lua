local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = false,

        bufname_exclude = { "/generated/*" },
        buftype_exclude = { "telescope", "terminal", "nofile", "quickfix", "prompt" },
        filetype_exclude = {
            "starter",
            "Trouble",
            "TelescopePrompt",
            "Float",
            "OverseerForm",
            "lspinfo",
            "checkhealth",
            "help",
            "man",
            "",
        },
    },
}

return M
