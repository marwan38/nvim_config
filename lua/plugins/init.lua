return {
    {
        "tpope/vim-fugitive",
        cmd = { "G" },
        config = function()
            local fugitive_augroup = vim.api.nvim_create_augroup("fugitive_config", {})
            vim.api.nvim_create_autocmd("FileType", {
                group = fugitive_augroup,
                pattern = "fugitive",
                callback = function(ctx)
                    vim.keymap.set("n", "P", function()
                        local confirmed = vim.fn.confirm("Confirm git push?", "&Yes\n&No")
                        if confirmed then
                            vim.cmd "Git push"
                        end
                    end, { buffer = ctx.buf })
                end,
            })
        end,
    },
    { "tpope/vim-surround" },
    { "norcalli/nvim-colorizer.lua" },
    { "windwp/nvim-autopairs", config = true }, -- See `config` under https://github.com/folke/lazy.nvim#-plugin-spec
    { "numToStr/Comment.nvim", config = true },
}
