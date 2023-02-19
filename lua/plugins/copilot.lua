return {
    "github/copilot.vim",
    init = function()
        vim.api.nvim_set_var("copilot_filetypes", {
            ["dap-repl"] = false,
        })
    end,
}
