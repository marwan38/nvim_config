local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-null-ls.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "jayp0521/mason-nvim-dap.nvim",
        -- Rust
        "simrat39/rust-tools.nvim",
        -- LSP Status.. nice to have.
        "j-hui/fidget.nvim",
        -- Useful status updates for LSP
        "folke/neodev.nvim",
        -- Typescript lsp
        "jose-elias-alvarez/typescript.nvim",
    },
}

M.config = function()
    local lsp_utils = require "user.lsp"

    require("mason").setup()
    require("mason-lspconfig").setup()

    -- Setup neovim lua configuration
    require("neodev").setup()

    lsp_utils.setup_servers()

    require("mason-null-ls").setup {
        ensure_installed = nil,
        automatic_installation = true,
        automatic_setup = false,
    }

    -- Turn on lsp status information
    require("fidget").setup()

    vim.diagnostic.config {
        virtual_text = {
            source = "always",
        },
        float = {
            source = "always",
        },
    }
end

return M
