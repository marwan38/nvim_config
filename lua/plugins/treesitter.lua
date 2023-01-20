return {
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

    {
        "mfussenegger/nvim-treehopper",
        keys = { { "m", mode = { "o", "x" } } },
        config = function()
            vim.keymap.set({ "o", "x" }, "m", function()
                local tsht = require "tsht"
                tsht.nodes()
            end, { silent = true })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        config = true,
    },

    {
        "windwp/nvim-ts-autotag",
        ft = {"typescriptreact"},
        config = true
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "bash",
                    "gitcommit",
                    "gitignore",
                    "graphql",
                    "help",
                    "html",
                    "javascript",
                    "jsdoc",
                    "jsonc",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "php",
                    "regex",
                    "rust",
                    "scss",
                    "sql",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "yaml",
                    "json",
                },
                sync_install = false,
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = false },
                context_commentstring = { enable = true, enable_autocmd = false },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<C-s>",
                        node_decremental = "<C-bs>",
                    },
                },
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { "BufWrite", "CursorHold" },
                },
                textsubjects = {
                    enable = false,
                    keymaps = {
                        ["."] = "textsubjects-smart",
                        [";"] = "textsubjects-container-outer",
                    },
                },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = true, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                    },
                    lsp_interop = {
                        enable = false,
                        peek_definition_code = {
                            ["gD"] = "@function.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
                matchup = {
                    enable = true
                }
            }
        end,
    },
}
