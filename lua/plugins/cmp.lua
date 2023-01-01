local M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-emoji",
        "onsails/lspkind-nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
}

M.config = function()
    local cmp = require "cmp"
    local lspkind = require "lspkind"

    cmp.setup {
        mapping = {
            ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-u>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<c-y>"] = cmp.mapping(
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                },
                { "i", "c" }
            ),
            ["<M-y>"] = cmp.mapping(
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                { "i", "c" }
            ),

            ["<c-space>"] = cmp.mapping {
                i = cmp.mapping.complete {},
                c = function(
                    _ --[[fallback]]
                )
                    if cmp.visible() then
                        if not cmp.confirm { select = true } then
                            return
                        end
                    else
                        cmp.complete()
                    end
                end,
            },

            ["<tab>"] = cmp.config.disable,
        },

        -- Youtube:
        --    the order of your sources matter (by default). That gives them priority
        --    you can configure:
        --        keyword_length
        --        priority
        --        max_item_count
        --        (more?)
        sources = cmp.config.sources({
            { name = "nvim_lua" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "emoji" },
        }, {
            { name = "path" },
            { name = "buffer", keyword_length = 5 },
        }, {
            { name = "gh_issues" },
        }),
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        formatting = {
            format = lspkind.cmp_format {
                with_text = true,
                menu = {
                    buffer = "[buf]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[api]",
                    path = "[path]",
                    luasnip = "[snip]",
                    gh_issues = "[issues]",
                },
            },
        },
        view_entries = {
            native = true,
        },

        experimental = {
            -- Let's play with this for a day or two
            ghost_text = false,
        },
    }
end

return M
